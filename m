Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD2AC33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B662084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="Savwc/nA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgAMPCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:02:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46969 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgAMPCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:02:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so8877553wrl.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 07:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UbXanDSkJAjL9L+fEl28B4vx56/nIIcQjO42Io5r9Js=;
        b=Savwc/nAAmWX4tk71jKM76OzsTwxT60wzsbyf3u4XJNh+eJSPtbPeSF56NubQukRhW
         nMOUIxfb/wZxDer1w5QrFY/91gevXhfp0pBo/iTYNqc7tByBGO6w8PMNI8RV+hA2KOa1
         CIAV5glkXWWhSU2xLOuSJjkaZsQJeNDfD8oKBPBaWX3aHLLI9Qq04PP/aqmvM0kp3B8B
         VsMeUti7MpW692T3dcpkwXjWDpqst8vDCFwvRjfizKwycYk539IEHrhSd4MGrqlTFl8U
         ziCikN+9gIbM78zQe2vr16x+EEaQ/OPmjSigYxoZMgzEU6kiuivaeT1gEA0IsFeHqHQ8
         GBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UbXanDSkJAjL9L+fEl28B4vx56/nIIcQjO42Io5r9Js=;
        b=jYX+ynGvgbRGutotZQQKKLNeJkmeNt4/I+ZOyR6rVH7tWS4S3q2PPAB6QLkpHU5htC
         9tmiNynvcZvqE3ZogJ5c4MvCEr3i0DS6WURe+S2qxsO815ZVtn8wLfoQ4PAd0Iz4/EPA
         +GZG+e4GbItWJMpUWpv5TzXd0B09Wxw4jB7+svyBgHK6XPZjR/oEVPftXpcljCXbMuvX
         /yglKJvcwitqpYBd/yqG1NMU3GfEliGNQbmkQBhpZCAgwNg+1htykZ5AlHGvryPTIpIv
         qvqTgbe/pK0yXzYSUizV7RVI4mOIRixUFG8kqYtbmDgsxwY4mHl+2hZ6Ee0wmCfEP77K
         ywWA==
X-Gm-Message-State: APjAAAVtfDDAp3b/dkhKYVpiSyMg5gUW/brrAylHIylvD4pCA6po3yxt
        rkFb9fQNbYwhF5kfnMfoIydxJw==
X-Google-Smtp-Source: APXvYqyHw40BJr+qa9qyg6IKZPNKVCksZzZdhKvejVAl8rZzCwGoPKxfxeroYijLmmQQ2VKsmm490w==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr19303551wrc.175.1578927730176;
        Mon, 13 Jan 2020 07:02:10 -0800 (PST)
Received: from localhost (ip-78-102-249-43.net.upcbroadband.cz. [78.102.249.43])
        by smtp.gmail.com with ESMTPSA id q68sm15648002wme.14.2020.01.13.07.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 07:02:06 -0800 (PST)
Date:   Mon, 13 Jan 2020 16:02:02 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, sd@queasysnail.net, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, allan.nielsen@microchip.com,
        camelia.groza@nxp.com, Simon.Edelhaus@aquantia.com,
        Igor.Russkikh@aquantia.com, jakub.kicinski@netronome.com
Subject: Re: [PATCH net-next v5 06/15] net: macsec: add nla support for
 changing the offloading selection
Message-ID: <20200113150202.GC2131@nanopsycho>
References: <20200110162010.338611-1-antoine.tenart@bootlin.com>
 <20200110162010.338611-7-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110162010.338611-7-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Jan 10, 2020 at 05:20:01PM CET, antoine.tenart@bootlin.com wrote:

[...]


>+static int macsec_upd_offload(struct sk_buff *skb, struct genl_info *info)
>+{
>+	struct nlattr *tb_offload[MACSEC_OFFLOAD_ATTR_MAX + 1];
>+	enum macsec_offload offload, prev_offload;
>+	int (*func)(struct macsec_context *ctx);
>+	struct nlattr **attrs = info->attrs;
>+	struct net_device *dev, *loop_dev;
>+	const struct macsec_ops *ops;
>+	struct macsec_context ctx;
>+	struct macsec_dev *macsec;
>+	struct net *loop_net;
>+	int ret;
>+
>+	if (!attrs[MACSEC_ATTR_IFINDEX])
>+		return -EINVAL;
>+
>+	if (!attrs[MACSEC_ATTR_OFFLOAD])
>+		return -EINVAL;
>+
>+	if (nla_parse_nested_deprecated(tb_offload, MACSEC_OFFLOAD_ATTR_MAX,
>+					attrs[MACSEC_ATTR_OFFLOAD],
>+					macsec_genl_offload_policy, NULL))
>+		return -EINVAL;
>+
>+	dev = get_dev_from_nl(genl_info_net(info), attrs);
>+	if (IS_ERR(dev))
>+		return PTR_ERR(dev);
>+	macsec = macsec_priv(dev);
>+
>+	offload = nla_get_u8(tb_offload[MACSEC_OFFLOAD_ATTR_TYPE]);
>+	if (macsec->offload == offload)
>+		return 0;
>+
>+	/* Check if the offloading mode is supported by the underlying layers */
>+	if (offload != MACSEC_OFFLOAD_OFF &&
>+	    !macsec_check_offload(offload, macsec))
>+		return -EOPNOTSUPP;
>+
>+	if (offload == MACSEC_OFFLOAD_OFF)
>+		goto skip_limitation;
>+
>+	/* Check the physical interface isn't offloading another interface
>+	 * first.
>+	 */
>+	for_each_net(loop_net) {
>+		for_each_netdev(loop_net, loop_dev) {
>+			struct macsec_dev *priv;
>+
>+			if (!netif_is_macsec(loop_dev))
>+				continue;
>+
>+			priv = macsec_priv(loop_dev);
>+
>+			if (priv->real_dev == macsec->real_dev &&
>+			    priv->offload != MACSEC_OFFLOAD_OFF)
>+				return -EBUSY;
>+		}
>+	}
>+
>+skip_limitation:
>+	/* Check if the net device is busy. */
>+	if (netif_running(dev))
>+		return -EBUSY;
>+
>+	rtnl_lock();
>+
>+	prev_offload = macsec->offload;
>+	macsec->offload = offload;
>+
>+	/* Check if the device already has rules configured: we do not support
>+	 * rules migration.
>+	 */
>+	if (macsec_is_configured(macsec)) {
>+		ret = -EBUSY;
>+		goto rollback;
>+	}

I wonder, did you consider having MACSEC_OFFLOAD_ATTR_TYPE attribute
passed during the macsec device creation (to macsec_newlink), so the
device is either created "offloded" or not? Looks like an extra step.
Or do you see a scenario one would change "offload" setting on fly?
If not, I don't see any benefit in having this as a separate command.

[...]

>+	{
>+		.cmd = MACSEC_CMD_UPD_OFFLOAD,
>+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>+		.doit = macsec_upd_offload,
>+		.flags = GENL_ADMIN_PERM,
>+	},

[...]
