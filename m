Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066C0C35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 07:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFBE20702
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 07:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="PnO+Ao1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgBEH5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 02:57:40 -0500
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:57095 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727231AbgBEH5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 02:57:39 -0500
Received: from [192.168.2.10] ([46.9.235.248])
        by smtp-cloud7.xs4all.net with ESMTPA
        id zFYyiXwsAVuxOzFZ2iON1x; Wed, 05 Feb 2020 08:57:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1580889456; bh=Zon7+wQq6Y/OezBpVLpCFEKggV/uB8j1JtLlS5DUs4g=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=PnO+Ao1a3gALRFP16EWuypfaSxiI7wukdAi3iV3IIWqREdBDN7WXancubsZigZSN7
         X8mxQQFiffs8g+r2999nlcv5oUAr9m4AFQFdII0t2WrzSNJMuqfoJf6U0av7WijK+x
         EHzH9yIie35y4NhBsiSp7yZhp+RCOWldqUbXEsiEnCOLmuoZTYFRVwgjuG4pB6LPcE
         vu2SlFcnLHOfzPDD2kThZIyFJAfNL+SJ8zVp2nOFm7OWYPeyzIBRivmUbIy4oCsfnJ
         ZWQr4en4ylqmG3qiXQgwhpcAG+PxoayH0BvocyYMvNdrIBmVMqZDT5BfVNXlC4tHRF
         RhlD0UODDFkHQ==
Subject: Re: [RFC PATCH v1 0/5] Add Tegra driver for video capture
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, frankc@nvidia.com
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1580235801-4129-1-git-send-email-skomatineni@nvidia.com>
 <098ac46f-fe13-f215-b9a4-aa8d01395592@xs4all.nl>
 <6c3d2557-8982-37bf-810a-6d9faad9e5a4@nvidia.com>
 <9c4775f2-8188-43f4-1de1-56620fad2e7c@xs4all.nl>
 <af813a4e-339c-4254-75a0-8db995fe2aba@nvidia.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <474ca8c5-4735-1707-d6f6-cf541bfeb525@xs4all.nl>
Date:   Wed, 5 Feb 2020 08:57:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <af813a4e-339c-4254-75a0-8db995fe2aba@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfH6omILRaT9sm0XhO0Kb85QAqiu7fDEbkga/0I8tPf5vU6is6YciSTeryOxUEvcb/d73otPRnDpn20BZCasUvUtOy4YajrmKQk5Qm/2MDHevnv0NuUlN
 1CzI4nx3arzn/x6o5Nztw1T2zsU2ixteauyiLs1GEATKt4y0IXCL3KUvLQYs1tLIrT0Uu4Uc3c6+yp6vsbS0+Sx99ha7cWYaXbMlGyqcU4aqZjtwPfcVyuSn
 sGYgbNx07aBlyezqOsgk/rF/QtxMXytLgkl4PwG7i9U1PZdbElzhHdhKtK98TDvwzLT+KTf/cJ+N456YhbDVdedtgv3yTwQMmvoexQhWBS43IBblKdGbY3oG
 wxdqUfvrzk5arnpPqOihGExs9k7lJ8CWtXLdI6I6gD7nCyNog3+2u8rwj6zaKK5icV2bZCM6Uf69pk9xaSCvvNB54O5XSEBoryFx0tzaDiOry4I3HLw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/20 8:02 PM, Sowjanya Komatineni wrote:
>>>> I also noticed that changing the test pattern while streaming did not seem to have
>>>> any effect until I stop and restart streaming. Is that a limitation of the HW or of
>>>> the driver?
>>> Do you mean changing test pattern mode of different channel while other
>>> channels are streaming?
>> No, from the same channel. E.g. v4l2-ctl --stream-mmap, then do from another
>> console 'v4l2-ctl -c test-pattern=1'.
>>
>> It depends on the hardware whether or not you can change the test pattern
>> while streaming. But it is nice for testing if this is possible.
> 
> Test-pattern mode changes during active streaming will not get set as 
> test-pattern mode is in CSI and mode is set every time during the start 
> of streaming and then VI keeps capturing the frames.
> 
> basically its during CSI subdevice stream enable.

OK. Just add a little comment either at the point the control is created or
where the control is set in vi_s_ctrl(). It's just to document that this
will only take effect at the next streamon.

Regards,

	Hans
