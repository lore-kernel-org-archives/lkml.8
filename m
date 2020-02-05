Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE01C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45725214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580940070;
	bh=F4eZGs0ENIEX+E8IrssLA5F+z3gn6DtG+kk+w1CWF30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UYO9M6zOa2KW+6yGKdR+8GaJuXfsdRE7nyHlGzNgJHzz86FJ9N/MgPcP16rELhiao
	 KPppYYftMdbI4X5dI+D+ch52HJguCkgcxTSah0x5qlzpCSuUrinQs/tpROfLtyYhB0
	 XQm7Mapn2Gv18oj3grrPB13IveX4aajitdMF6ag4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgBEWBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:01:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:54840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgBEWBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:01:09 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99A2E2082E;
        Wed,  5 Feb 2020 22:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580940068;
        bh=F4eZGs0ENIEX+E8IrssLA5F+z3gn6DtG+kk+w1CWF30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=biiN4GiPlM07CK3f0l8OwIo7Zywvjnzwrs+ksn8+Y/d7lRdfjwYcz7agiKQbFIIpI
         jkDSHsgLHz9amzicK9zQQ/FS5PPvHt+j42El15e6+8hjps4iyT0v1X2cRwwmHlRgVg
         R0r7HyZTY7SEjX7Fwc5VQfJIAeGnkw8KSDuxl5n4=
Date:   Wed, 5 Feb 2020 17:01:07 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org, kys@microsoft.com,
        jamorris@microsoft.com
Subject: Re: [PATCH] Documentation/process: Change Microsoft contact for
 embargoed hardware issues
Message-ID: <20200205220107.GH31482@sasha-vm>
References: <20200205213621.31474-1-sashal@kernel.org>
 <20200205214716.GA1468203@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200205214716.GA1468203@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 09:47:16PM +0000, Greg KH wrote:
>On Wed, Feb 05, 2020 at 04:36:21PM -0500, Sasha Levin wrote:
>> Remove Sasha Levin as the Microsoft contact. A new contact will be
>> assigned by Microsoft.
>>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  Documentation/process/embargoed-hardware-issues.rst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
>> index 33edae654599..a6f4f6e5c78b 100644
>> --- a/Documentation/process/embargoed-hardware-issues.rst
>> +++ b/Documentation/process/embargoed-hardware-issues.rst
>> @@ -250,7 +250,7 @@ an involved disclosed party. The current ambassadors list:
>>    Intel		Tony Luck <tony.luck@intel.com>
>>    Qualcomm	Trilok Soni <tsoni@codeaurora.org>
>>
>> -  Microsoft	Sasha Levin <sashal@kernel.org>
>> +  Microsoft
>
>That's fine, but when will that contact "be assigned"?  I'd rather not

Hopefully "soon" :)

>go without one at all for no good reason other than "people need to
>figure their stuff out" :)

There's not much I can do on behalf of Microsoft anymore, so leaving me
there will be misleading.

-- 
Thanks,
Sasha
