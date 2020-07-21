Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CA7C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 645A020773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595294987;
	bh=RleFPPOuqx0c/rRkU7q5uVFxbzFj5p7ERSlLBGAKH30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fTnE2zvySClOBV5mtB0ghLz+VuT3ERUuS86AlkI7FsqUny42H7ect9apP0QzGkEx+
	 DVSvWwN5sbzhs+c9coQxKUg6BLDLXmUKCgyRdnPesjogCaWx/NqL6l+Yx3Ggjl4aej
	 d4Wd1Fkj0M1JICAwnc/ngYYMh5rNgJ+/DNli//HU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGUB3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 21:29:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgGUB3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 21:29:46 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3461B20714;
        Tue, 21 Jul 2020 01:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595294985;
        bh=RleFPPOuqx0c/rRkU7q5uVFxbzFj5p7ERSlLBGAKH30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZVV+ScaBB7lxUheq3NtRpNDUU85fyh4R59g4LheiH9UhpgEy8DUwjsYNg9j/F/tlL
         6d2x8YgnTOAC/+vTIPOY0/dVjqqh14/F3n4It2lh53YqElNvgwU3r6TfWz13eu77e8
         c2YffkQo9ryrIaX+npyTtZ8nRGVNWjfs5rr4vygg=
Date:   Mon, 20 Jul 2020 21:29:43 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 041/133] Revert "usb/ohci-platform: Fix a warning
 when hibernating"
Message-ID: <20200721012943.GA406581@sasha-vm>
References: <20200720152803.732195882@linuxfoundation.org>
 <20200720152805.704517976@linuxfoundation.org>
 <20200720210722.GA11552@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200720210722.GA11552@amd>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 11:07:22PM +0200, Pavel Machek wrote:
>Hi!
>On Mon 2020-07-20 17:36:28, Greg Kroah-Hartman wrote:
>> This reverts commit c83258a757687ffccce37ed73dba56cc6d4b8a1b.
>>
>> Eugeniu Rosca writes:
>>
>> On Thu, Jul 09, 2020 at 09:00:23AM +0200, Eugeniu Rosca wrote:
>> >After integrating v4.14.186 commit 5410d158ca2a50 ("usb/ehci-platform:
>> >Set PM runtime as active on resume") into downstream v4.14.x, we started
>> >to consistently experience below panic [1] on every second s2ram of
>> >R-Car H3 Salvator-X Renesas reference board.
>> >
>> >After some investigations, we concluded the following:
>> > - the issue does not exist in vanilla v5.8-rc4+
>> > - [bisecting shows that] the panic on v4.14.186 is caused by the lack
>> >   of v5.6-rc1 commit 987351e1ea7772 ("phy: core: Add consumer device
>> >   link support"). Getting evidence for that is easy. Reverting
>> >   987351e1ea7772 in vanilla leads to a similar backtrace [2].
>> >
>> >Questions:
>> > - Backporting 987351e1ea7772 ("phy: core: Add consumer device
>> >   link support") to v4.14.187 looks challenging enough, so probably not
>> >   worth it. Anybody to contradict this?
>
>I'm not sure about v4.14.187, but backport to v4.19 is quite simple
>(just ignore single non-existing file) and passes basic testing.
>
>Would that be better solution for 4.19 and newer?

If Eugeniu could confirm that doing so on 4.19+ works for him, sure.

-- 
Thanks,
Sasha
