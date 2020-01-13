Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9599C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C324207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="BjSBuIz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgAMOe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:34:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43296 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgAMOe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 09:34:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so8798353wre.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 06:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OmcWfIBXkgyvN2cgft6r1ms+tR1sv2tTxJ3TL0EKA+g=;
        b=BjSBuIz0rqihO1u6oVG994zIp4LszvgfRyi3TQIDE9elXW2RNLXBA9Qa9hSk9WYUHp
         4evf6MYWH1Uk3c/DnxD20kDx5llyTzfvKjoYm575UEKChy+28T2/c/S2YoxHsMjFpemo
         zfyIuvsQ4up1UMLF2NkbUJWPej4HkVaUmNxpsQBBauf+TO0NA9FNfWzogkLx/Hfm142N
         L5pP4sAxO+x4dkQwdEgFDOngz+NMzpvqYmnc6FW9v/jp/bqgYAMAfATqx/VgozdgbTte
         4C/x5MLMYcsIojpEux8gaPd5/Yk2TLwM8fRV/J+4nbX//exFdx4bbwLzZx1m+YlxHAJE
         sQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OmcWfIBXkgyvN2cgft6r1ms+tR1sv2tTxJ3TL0EKA+g=;
        b=NRt2NtiLv0a0aj9LGey4v9IoEsM9CLWTn0MictvdpZlv/nGhWP5Vy2A28LNup636c0
         G0bIqC+QPTB+ID7gqD7ReeBCJnhPqLRy+5jZrvM9pszMw1qvjlw3FwzGqa7nKRMESPBM
         P7PFoiVBJ0dXJCQVxAfsuya4ia/Y25EztVGoIqpYjSNXcn81tr7t1Eh5i9P24Dq/lTZt
         iJqkH4fJQJ0X3mseX9AHAOGsf1ERbcpsnJqqCKcSBE5tp7gz7uC2aHZ+rxaplpxm13TE
         nJv6nsIw+9Z8XbNxG46/bwvZJhv8FAhzkUfOGDraBo2IVus7XJ4/eCwqhKjiR7B9vGzu
         pikg==
X-Gm-Message-State: APjAAAXE1fitt+s/u7cYQ8/DFdwkf3YOWql1xuLNmrnEJjhediXNfSRG
        eXSygPH0s4tGmYTbjzncPrfb9A==
X-Google-Smtp-Source: APXvYqzs5RfhHexyHDgfnn5rf2OytVWc6odXONn7jRukll8feWi5Dn5ZVX6pU3hEsY5aT/Q+0PfQmw==
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr17870446wrw.370.1578926094258;
        Mon, 13 Jan 2020 06:34:54 -0800 (PST)
Received: from localhost (ip-78-102-249-43.net.upcbroadband.cz. [78.102.249.43])
        by smtp.gmail.com with ESMTPSA id l19sm14443297wmj.12.2020.01.13.06.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 06:34:53 -0800 (PST)
Date:   Mon, 13 Jan 2020 15:34:52 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, sd@queasysnail.net, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, allan.nielsen@microchip.com,
        camelia.groza@nxp.com, Simon.Edelhaus@aquantia.com,
        Igor.Russkikh@aquantia.com, jakub.kicinski@netronome.com
Subject: Re: [PATCH net-next v5 05/15] net: macsec: hardware offloading
 infrastructure
Message-ID: <20200113143452.GA2131@nanopsycho>
References: <20200110162010.338611-1-antoine.tenart@bootlin.com>
 <20200110162010.338611-6-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110162010.338611-6-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Jan 10, 2020 at 05:20:00PM CET, antoine.tenart@bootlin.com wrote:

Couple nitpicks I randomly spotted:

[...]


>+static bool macsec_is_offloaded(struct macsec_dev *macsec)
>+{
>+	if (macsec->offload == MACSEC_OFFLOAD_PHY)
>+		return true;
>+
>+	return false;

Just:
	return macsec->offload == MACSEC_OFFLOAD_PHY;


>+}
>+
>+/* Checks if underlying layers implement MACsec offloading functions. */
>+static bool macsec_check_offload(enum macsec_offload offload,
>+				 struct macsec_dev *macsec)
>+{
>+	if (!macsec || !macsec->real_dev)
>+		return false;
>+
>+	if (offload == MACSEC_OFFLOAD_PHY)

You have a helper for this already - macsec_is_offloaded(). No need for
"offload" arg then.


>+		return macsec->real_dev->phydev &&
>+		       macsec->real_dev->phydev->macsec_ops;
>+
>+	return false;
>+}
>+
>+static const struct macsec_ops *__macsec_get_ops(enum macsec_offload offload,
>+						 struct macsec_dev *macsec,
>+						 struct macsec_context *ctx)
>+{
>+	if (ctx) {
>+		memset(ctx, 0, sizeof(*ctx));
>+		ctx->offload = offload;
>+
>+		if (offload == MACSEC_OFFLOAD_PHY)

Same here.


>+			ctx->phydev = macsec->real_dev->phydev;
>+	}
>+
>+	return macsec->real_dev->phydev->macsec_ops;
>+}
>+

[...]
