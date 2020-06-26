Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACE7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F07E7207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593199809;
	bh=jA5es0Ur1eplSo2ilpi6BzKAmXLfXei8r6/oNcoJiZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZDnevXABHS+6NiuD/9XC5tLoiAvr6VQ37h/WQ2cWbLBUTbu3qA8MUeGS1NWGW2dYs
	 GTUR0xWhRlezNUeliFuTfGqBXhFGI3/8Najxaz2BAS+KVOkyeRzKo7L6mIV68/M4Nw
	 HEJSqpu4IJrRY2nu2qeR7lG3c/tjjQIenCAp7p94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgFZTaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 15:30:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgFZTaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 15:30:07 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C0982070A;
        Fri, 26 Jun 2020 19:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593199806;
        bh=jA5es0Ur1eplSo2ilpi6BzKAmXLfXei8r6/oNcoJiZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mk7/e/A3wZj4mbsysOyZ/farVgeJBfHabvlxR/7PNNJrTwo7gKRjDm2oX0Kpehh2y
         38Aes/7SOkcxFEahMDOvqL3OtVlTfNX2nQi6FxVTypHNwg8FF4RDgua3jgog/gB1qE
         UOVr1Hhq6z84tCVwBdQZxW5u1a2xlPjvVR8Rd4DM=
Date:   Fri, 26 Jun 2020 15:30:05 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 4.19 012/206] ALSA: hda/realtek - Introduce polarity for
 micmute LED GPIO
Message-ID: <20200626193005.GH1931@sasha-vm>
References: <20200623195316.864547658@linuxfoundation.org>
 <20200623195317.567695457@linuxfoundation.org>
 <20200625190255.GB5531@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200625190255.GB5531@duo.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 09:02:55PM +0200, Pavel Machek wrote:
>Hi!
>
>> Currently mute LED and micmute LED share the same GPIO polarity.
>>
>> So split the polarity for mute and micmute, in case they have different
>> polarities.
>
>> +++ b/sound/pci/hda/patch_realtek.c
>> @@ -94,6 +94,7 @@ struct alc_spec {
>>
>>  	/* mute LED for HP laptops, see alc269_fixup_mic_mute_hook() */
>>  	int mute_led_polarity;
>> +	int micmute_led_polarity;
>>  	hda_nid_t mute_led_nid;
>>  	hda_nid_t cap_mute_led_nid;
>>
>
>This variable will be always zero in 4.19.130... so the patch does not
>really do anything.
>
>In mainline, commit 3e0650ab26e20 makes use of this variable.

I'll queue 3e0650ab26e20 for 4.19, thanks!

-- 
Thanks,
Sasha
