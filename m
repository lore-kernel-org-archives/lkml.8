Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39319C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EED5520771
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgHLQkJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:40:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59809 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgHLQkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:40:04 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1k5tnF-0006GB-DC
        for linux-kernel@vger.kernel.org; Wed, 12 Aug 2020 16:40:01 +0000
Received: by mail-pg1-f199.google.com with SMTP id 36so1981300pgz.18
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 09:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6Ji1lqucG/grb2OVN+O0IrjUWDOjIPmMeJi8EGBOR3U=;
        b=Y4JbbOJK3/oI7lFKWIsUx+kIuTB6m186iEH0W3QajOttOeLQj+w0dJ5aR4lafw5BOE
         enJ3+jbxRaJa/SBlK9hyeFPdFHeApbNrh+Gxv/XpikBRScnxZ1SVoPdCvVzOTJcLAhnK
         mURmzvTqrWoE1Gm22vbOOFWqflUSvpAhRxn7W5iHxSp7zg36y1XjXu5eeHnKxz1xpkBW
         auIkYC7vZo+CgQnqjGwzfq/Le8rpVFT7Zc+5vqPtqUAJn00yZvsj9MkAsrV/sSIIg4iE
         SS/3l/XuUo4XWCXE3SEWwDbyd8+cNsii7BoN36kGjqveYNueQDY7V+fuy822NHPqSNjF
         KPbQ==
X-Gm-Message-State: AOAM532BKmHN1VXn7gys1p9hZX6jtE5CAZtL1feeHgY1A9fWtJl01FkP
        ic24WmaAX2tjAHhd2QndVIOZQdVeQULvNZPfZs4GqwEts6qJP3WnLYolL78qYI6kTDc30nHYtuf
        0tICWd2NumhDRmZFgIriYc0FFlsdCFWjJPqzfKYdpaw==
X-Received: by 2002:a17:90b:817:: with SMTP id bk23mr886008pjb.46.1597250400073;
        Wed, 12 Aug 2020 09:40:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw53UL6r2FJ490XaYZR/YirtLM+MEb+vxIbXVyQDwdw7BkTzweu8CBj8oB5aCzPKtgJexKnhA==
X-Received: by 2002:a17:90b:817:: with SMTP id bk23mr885980pjb.46.1597250399735;
        Wed, 12 Aug 2020 09:39:59 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id p127sm2835148pfb.17.2020.08.12.09.39.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2020 09:39:59 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] ALSA: hda/hdmi: Use force connectivity quirk on another
 HP desktop
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <s5ho8nfx3v9.wl-tiwai@suse.de>
Date:   Thu, 13 Aug 2020 00:39:56 +0800
Cc:     tiwai@suse.com, Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Nikhil Mahale <nmahale@nvidia.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Aaron Plattner <aplattner@nvidia.com>,
        Harsha Priya <harshapriya.n@intel.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <0466883E-8F02-4226-B153-F34558FC3A4A@canonical.com>
References: <20200811095336.32396-1-kai.heng.feng@canonical.com>
 <44573652-9ECF-4EC5-A234-DBB21FC90CC7@canonical.com>
 <s5ho8nfx3v9.wl-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 12, 2020, at 23:47, Takashi Iwai <tiwai@suse.de> wrote:
> 
> On Wed, 12 Aug 2020 17:43:27 +0200,
> Kai-Heng Feng wrote:
>> 
>> Hi,
>> 
>>> On Aug 11, 2020, at 17:53, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>> 
>>> There's another HP desktop has buggy BIOS which flags the Port
>>> Connectivity bit as no connection.
>>> 
>>> Apply force connectivity quirk to enable DP/HDMI audio.
>>> 
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> 
>> I guess this patch was omitted as well...
> 
> Not omitted but applied to a wrong internal branch, sorry.
> Now I rebased to the proper branch and pushed out.

Thanks a lot!

Kai-Heng

> 
> 
> thanks,
> 
> Takashi
> 
>> 
>> Kai-Heng
>> 
>>> ---
>>> sound/pci/hda/patch_hdmi.c | 1 +
>>> 1 file changed, 1 insertion(+)
>>> 
>>> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
>>> index 4bbd12d3b1b5..b8c8490e568b 100644
>>> --- a/sound/pci/hda/patch_hdmi.c
>>> +++ b/sound/pci/hda/patch_hdmi.c
>>> @@ -1863,6 +1863,7 @@ static int hdmi_add_cvt(struct hda_codec *codec, hda_nid_t cvt_nid)
>>> }
>>> 
>>> static const struct snd_pci_quirk force_connect_list[] = {
>>> +	SND_PCI_QUIRK(0x103c, 0x870f, "HP", 1),
>>> 	SND_PCI_QUIRK(0x103c, 0x871a, "HP", 1),
>>> 	{}
>>> };
>>> -- 
>>> 2.17.1
>>> 
>> 

