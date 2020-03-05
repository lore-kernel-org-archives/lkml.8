Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F941C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A1C208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=eikelenboom.it header.i=@eikelenboom.it header.b="iD+QA+DB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbgCELNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 06:13:31 -0500
Received: from server.eikelenboom.it ([91.121.65.215]:55322 "EHLO
        server.eikelenboom.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgCELNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 06:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=eikelenboom.it; s=20180706; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eyfIMXjmL6HGrxriluW6p04Q9Bp2OTgLI/nlQbiw3dI=; b=iD+QA+DBX+U3KoCd0EAFqU7sib
        iTrPrXzKJRs0o7TMqUpb3OwVfUjuLG6df9ld8WLCbBy2JFD3YiE06xWKfP2PVYz6fv2d+XKYX6WfS
        vNAeO/S2hPV0SpaAPzBHALOTOQRHqNI6ubE8zVvwZ8cQ9IWEdrPDmjdSCTFBZxF5swBA=;
Received: from ip4da85049.direct-adsl.nl ([77.168.80.73]:34132 helo=[10.97.34.6])
        by server.eikelenboom.it with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <linux@eikelenboom.it>)
        id 1j9oTS-0004Av-MW; Thu, 05 Mar 2020 12:15:30 +0100
Subject: Re: xen boot PVH guest with linux 5.6.0-rc4-ish kernel: general
 protection fault, RIP: 0010:__pv_queued_spin_lock_slowpath
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <d323139d-97ef-0c76-8ec6-a669f5b0ba2d@eikelenboom.it>
 <bb3965c5-6724-b261-260b-d07e40176802@suse.com>
 <1bd973f7-f863-7401-870a-2569905e19a0@eikelenboom.it>
 <c95163ff-39a5-259a-16b4-23534ce4d2a5@suse.com>
From:   Sander Eikelenboom <linux@eikelenboom.it>
Message-ID: <db0a09d0-55a5-4f49-c9fa-67c4f074935c@eikelenboom.it>
Date:   Thu, 5 Mar 2020 12:13:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c95163ff-39a5-259a-16b4-23534ce4d2a5@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2020 12:06, Jürgen Groß wrote:
> On 05.03.20 12:04, Sander Eikelenboom wrote:
>> On 05/03/2020 11:18, Jürgen Groß wrote:
>>> On 04.03.20 18:52, Sander Eikelenboom wrote:
>>>> Hi Juergen,
>>>>
>>>> Just tested a 5.6.0-rc4'ish kernel (8b614cb8f1dcac8ca77cf4dd85f46ef3055f8238, so it includes the xen fixes from x86 trees).
>>>> Xen is the latest xen-unstable, dom0 kernel is 5.5.7.
>>>>
>>>> During boot of the PVH guest I got the splat below.
>>>> With a 5.5.7 kernel the guest boots fine.
>>>
>>> There were 2 bugs. I have sent the patches.
>>
>> Sure ?
>> Haven't seen them coming in ...
> 
> https://patchew.org/Xen/20200305100331.16790-1-jgross@suse.com/
> https://patchew.org/Xen/20200305100323.16736-1-jgross@suse.com/
> 
> 
> Juergen
> 
Ah I was not CC'ed.

Will give them a test, thanks.

--
Sander
