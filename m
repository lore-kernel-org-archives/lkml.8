Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49A4C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2879227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgCKIyO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:54:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48127 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbgCKIyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:54:14 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jBx7z-00046L-Pr
        for linux-kernel@vger.kernel.org; Wed, 11 Mar 2020 08:54:11 +0000
Received: by mail-pf1-f200.google.com with SMTP id 78so888417pfy.22
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 01:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EJWnh1S/r/UN0sDn/GSkUc/60c+WdDetrbhkwselzAg=;
        b=B8J4DBtvnUoPNWv2z4jz/l5WGOrZsAyZrIsMKdFvfVQOd1PEwti0UXeVcKefLyyRuV
         R9GHdGoOY5uV2+XWP1lPLI3lt4ia56pdZWBUBSlVfa0EpvREpNVwYYSU12N0pb+S+9kf
         9+t+bX8PzY1BBS1oqMvRt0Vcf0ZmTewDPB2H8dXOQOS6rxw3s8z5XVYZ1XkIII2jFbvH
         9HbL6slwyfB/JxQcEoGjfioMg43xKWW2uy/j3t3srw1t+nLLzhdKyDLRUqyYaIt9Y5Bw
         JRWW2CtgsuXwavgNAQQpwbFXxkw38le3SLL4y813Fwakr94OoE0p50NeofkpGLieDB4H
         A0DA==
X-Gm-Message-State: ANhLgQ15YeC89+Fh1uGPaVSJ+zrLUEAhANmZ+kjzFAdmyuGdjPxT9cvQ
        UyHvBVqiQ0HQRu9l+kS8U0qB/y1MacUmZjp2F3DHmjvD15EKdcRSKGQdOB9RmTSxBlE2dJAe/rN
        NECxlbDpw9Qda828RtrdDKDmvL9TxmydnSo9Ve6p4UQ==
X-Received: by 2002:a65:494f:: with SMTP id q15mr1837945pgs.383.1583916850396;
        Wed, 11 Mar 2020 01:54:10 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtm8So4/d3DEnR6dWVHPhIUH8t8Knc+iRilA2DGZRDO/zn7T+RrQ/v03vMqgAyTeD7rAD0jqw==
X-Received: by 2002:a65:494f:: with SMTP id q15mr1837929pgs.383.1583916850047;
        Wed, 11 Mar 2020 01:54:10 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id a24sm929062pfl.115.2020.03.11.01.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2020 01:54:09 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] ALSA: hda/realtek: Fix pop noise on ALC225
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <s5ho8t39yaz.wl-tiwai@suse.de>
Date:   Wed, 11 Mar 2020 16:54:07 +0800
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <65C45FA9-E58A-4EF2-AE42-5CF2AEF00F68@canonical.com>
References: <20200311061328.17614-1-kai.heng.feng@canonical.com>
 <s5ho8t39yaz.wl-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 11, 2020, at 14:54, Takashi Iwai <tiwai@suse.de> wrote:
> 
> On Wed, 11 Mar 2020 07:13:28 +0100,
> Kai-Heng Feng wrote:
>> 
>> Commit 317d9313925c ("ALSA: hda/realtek - Set default power save node to
>> 0") makes the ALC225 have pop noise on S3 resume and cold boot.
>> 
>> So partially revert this commit for ALC225 to fix the regression.
>> 
>> Fixes: 317d9313925c ("ALSA: hda/realtek - Set default power save node to 0")
>> BugLink: https://bugs.launchpad.net/bugs/1866357
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
> 
> Hrm, it's rather surprising.  The power_save_node was thought to be a
> cause of the pop noise, but in this case it fixes.  It's interesting
> because this codec chip has no loopback mixer, and the connection is
> directly from DAC to pin, so in theory, it shouldn't be influenced
> from other nodes.
> 
> Anyways, a slight concern is that this might cause a regression on
> another machine.  But who knows, maybe the influence is very limited.
> Let's apply it and see what happens.

If that happens I'll write a specific fixup for the affected model.

Kai-Heng

> 
> 
> thanks,
> 
> Takashi

