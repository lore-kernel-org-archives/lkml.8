Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B462C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 03:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD22520754
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 03:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsy9jEof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgCTDCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 23:02:45 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40065 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCTDCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 23:02:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so1905341plk.7;
        Thu, 19 Mar 2020 20:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wy2Rb8SY1Pz/c/o65ADYdzfkIZ3xe9SUJygVcDWd17g=;
        b=jsy9jEofnUXn+21zXMtuprVG8J+jXN9DsDWkV7vIF9V1EdUcihkMN+d4eP06Tpi6eK
         wYEp1qQpvtf/1sigok9t5ii//EZ3lnljCAMuvSdnm60Y6cVNHB1HWOxxZN7y92km4M2d
         kmjxngCkGCPpzYazTLN6agsyIvbWZfsebekdqaAMblIzUPZrPgj04EDlQBhV6cp3k2rp
         SIh85/aB2P9iVHIytGoPZHC2eInGAXBmfPrW/zaSWdiYxu4hr9I8++Ec+YCtBZoWkmLn
         um7TlH+J+dDqO69OjZ+IBKbg+lVj1MAqsGTGtfVLydktKxdqEwdGGPx52vdBddM94z97
         wqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wy2Rb8SY1Pz/c/o65ADYdzfkIZ3xe9SUJygVcDWd17g=;
        b=Rn9d2gJeDQHU2Q44aQkgqR+l/qlz6WphGhNIY1UPZicsPXP2X9Xih7Advgt+y87qhV
         GG4ge65Pzdtd5ZaItRbTretPvjw7eV0DqAjDtvLmqZv7hnjAYHMDPctzE84ZMAOEd+XX
         EHgvve2s7MrXfAi8uEPBOZwtr+FMfTujuXc8RBYGrUjDDItTSTq1BMKQqs3SBqG2QiPx
         KTV163pYwTE7JxwZs/5W4LxF5L+E90Mgh1wbhujAgJmlDlUwuv8gh2Nib/vUoh8+6+hg
         doAczwIDVIWdoG8+VH6o18Yic/WOraWrW7jO4gkWfhaMT3Pu2u+KgVoCdTPz65M5/EFS
         Xfew==
X-Gm-Message-State: ANhLgQ1OZaVIY8XHOApbwzsBMbrjDUY2Nc1s/8ve0QRxSanX+2MT3oAj
        qSu7sadFyggzZE1kqPtYBhPOL3Fs
X-Google-Smtp-Source: ADFU+vvO1H5mOGiH2ZWVqkt7aaUa2qpKhOVWG7PztaPxglK0QHDboUuqvypYeRa1ogJRj5kGF3ZqFg==
X-Received: by 2002:a17:902:b198:: with SMTP id s24mr6209268plr.89.1584673364104;
        Thu, 19 Mar 2020 20:02:44 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 5sm3752191pfw.98.2020.03.19.20.02.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Mar 2020 20:02:43 -0700 (PDT)
Date:   Thu, 19 Mar 2020 20:02:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Grant Peltier <grantpeltier93@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        adam.vaughn.xh@renesas.com
Subject: Re: [PATCH v2 1/2] hwmon: (pmbus) add support for 2nd Gen Renesas
 digital multiphase
Message-ID: <20200320030242.GA2413@roeck-us.net>
References: <cover.1584568073.git.grantpeltier93@gmail.com>
 <10f2ef1746e5d079ac3b3c6054ffd2bbfc314572.1584568073.git.grantpeltier93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10f2ef1746e5d079ac3b3c6054ffd2bbfc314572.1584568073.git.grantpeltier93@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 10:49:50AM -0500, Grant Peltier wrote:
> Extend the isl68137 driver to provide support for 2nd generation Renesas
> digital multiphase voltage regulators.
> 
> Signed-off-by: Grant Peltier <grantpeltier93@gmail.com>

I hate to (have to) say that, but there are lots of checkpatch errors and
warnings in this patch.

total: 7 errors, 4 warnings, 182 lines checked

That is really unnecessary. Please fix and resubmit.

Thanks,
Guenter
