Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D77C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAC52074C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uoO6oVmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgCKVYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 17:24:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42075 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgCKVYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 17:24:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id v11so4599966wrm.9;
        Wed, 11 Mar 2020 14:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fuyIUQ7b5CBLSZ8E0QJGAyWVlbMJzgaunPSPgIViZwk=;
        b=uoO6oVmZhvWxJWeOAuN27RkZ8JajNoW3OSeQqgmgf+5HU/hC0/ku1AZ2Svf3gScae3
         wpwfXGX0G4yNg2krZ2dRWnHF5IqZOxyBNVDYlZ1l08JxLa3a6Fm6UEn2VP7pxh/VbNxg
         N7p7HZabg6+wW+NTCbkdYaJ0txe+RB3FDQJUnhh91XP/Sv3tKe8FQqBe5zvZDc8qLLf/
         hdWTfdxA6gslW2U2WdZSW866CQ3/T6uQPIDF2gtYSjoAbaxCWdWNF78Qkt9nCpvTUgPz
         22ZOgs9ZOKsWn8MlZQ5HE6WNoroDDwbYA4tpsQkSx+tdl95+EbT8whx21NA5/cwdzhA5
         1+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fuyIUQ7b5CBLSZ8E0QJGAyWVlbMJzgaunPSPgIViZwk=;
        b=bdPTulpWtxooXZO/I3g9TGYMukXlYzDqG0lroHfIuYayikePfy7eIFbbF4TGd3S0sT
         vzLwusQL/ANtPdoQxB65BlcyKjf7IjUIVklrIdbubWqlYFG3oYO0cgtyelCypMQKZiL0
         2I9AS6XHLF+KB9iEWioT7+37s6O6SVdH5hUAaQTdNxjY04yqWISs3dXzM+H5pTjpzVhz
         mCHSC0T5PUQvRLeMdLDYRatsOL56bkN28tNjHVVe0VmZl7N0vViAc1aXvL0UTd/pc8EG
         8Ece8Gv+mt7/ynCydJXOP05vgJQfDm9BE+3JTXuzyq0BGFbnt6emIGfiwJzjvdvVQTvv
         wepA==
X-Gm-Message-State: ANhLgQ2P/yzVZb6lqyyK85ZcHjX9f9Mydi/vx/2BLDtegCAstl3H4wrT
        ztIiQkYXes6szK3AJ9XIaGjZKMGS
X-Google-Smtp-Source: ADFU+vuYd5Vi6zFvxP8WvwEA4pSeyb50560+pVCwg9vjetJLFM971+3tweYm9Zyh/wW8Sf20AjkZhw==
X-Received: by 2002:a5d:4683:: with SMTP id u3mr6742903wrq.251.1583961846711;
        Wed, 11 Mar 2020 14:24:06 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p8sm3023577wrw.19.2020.03.11.14.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 14:24:05 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com, nick.hudson@gmx.co.uk,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Nick Hudson <skrll@netbsd.org>
Subject: Re: [PATCH] ARM: bcm2835-rpi-zero-w: Add missing pinctrl name
Date:   Wed, 11 Mar 2020 14:24:02 -0700
Message-Id: <20200311212402.9934-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310182537.8156-1-nick.hudson@gmx.co.uk>
References: <20200310182537.8156-1-nick.hudson@gmx.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 18:25:37 +0000, nick.hudson@gmx.co.uk wrote:
> From: Nick Hudson <nick.hudson@gmx.co.uk>
> 
> Define the sdhci pinctrl state as "default" so it gets applied
> correctly and to match all other RPis.
> 
> Fixes: 2c7c040c73e9 ("ARM: dts: bcm2835: Add Raspberry Pi Zero W")
> 
> Signed-off-by: Nick Hudson <skrll@netbsd.org>
> ---

Applied to devicetree/fixes, thanks!
--
Florian
