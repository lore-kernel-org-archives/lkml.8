Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4717C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6587E2080D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588839786;
	bh=VbhDvdY34Jcu5KiAN1pZ92Y1fd0IZzNk42+LVNukGeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P1AqnU5E0rDBvJ3E1BjsKyJV/ZITH9AKJlG5yLjRyIfXPFCTjHRsWioYpY0fJg27Q
	 7cTshwAab14aEOoOn6DJA3mAztL4voqO7huugzdeM8OVYVCC8Cq0jF20vo0UFgMeCR
	 8ojUoS1cNVFwcaVinS3RYwpEk2axnke6KlAHKQEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgEGIXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 04:23:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgEGIXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 04:23:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A425120753;
        Thu,  7 May 2020 08:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588839785;
        bh=VbhDvdY34Jcu5KiAN1pZ92Y1fd0IZzNk42+LVNukGeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=trQNiFUBXZ5pVsEgPE3dB0CtGTaFJ0lFXJ1UzMHcsJz5mI12GHgK1TEEPCbKBLkUh
         lrkcdPgEPORrl6EmiDft00lZogxyfp5hJ6fJflMgERsTPtiU0dKC22iL62snqJ+4YQ
         RgJ8ohvn4YNU7Kkr6fFLqimacuJWzvsf5rLirVMw=
Date:   Thu, 7 May 2020 10:23:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     butt3rflyh4ck <butterflyhuangxx@gmail.com>
Cc:     security@kernel.org, syzkaller <syzkaller@googlegroups.com>,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: KASAN: use-after-free Write in snd_rawmidi_kernel_write1
Message-ID: <20200507082302.GF1024567@kroah.com>
References: <CAFcO6XMGT42wFBxEa01Ee5Msuecm+WiXnn4rc-VWkC4vTzycPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFcO6XMGT42wFBxEa01Ee5Msuecm+WiXnn4rc-VWkC4vTzycPg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 04:04:25PM +0800, butt3rflyh4ck wrote:
> I report a bug (in linux-5.7-rc1) found by syzkaller.
> 
> kernel config: https://github.com/butterflyhack/syzkaller-fuzz/blob/master/v5.7.0-rc1.config
> reproducer: https://github.com/butterflyhack/syzkaller-fuzz/blob/master/repro.cprog
> 
> I test the reproducer in linux-5.7-rc4 and crash too.

Great, care to create a fix for this and send it to the proper
maintainers?  That's the best way to get it fixed, otherwise it just
goes in the file with the rest of the syzbot reports we are burried
under.

thanks,

greg k-h
