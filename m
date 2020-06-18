Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC867C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93AC321548
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEKgvqkR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgFRJ6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:58:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49623 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727121AbgFRJ6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592474308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gbqjrwqFXRmxoGwqqNgfEHopA2VshMnaJanmKD0Qpms=;
        b=CEKgvqkR5XyIzJpXWyN5F+UZBEJdEo5hZp3PRHVR4T9C/5zHIONKpRpmmRccu4p5/FvXXh
        u4TOdtO653hNHsqtPNQAx/Z3P+dF1ATEER2D5aDuG25jQKtPeQghhuf6/0OWstLZ1288Wz
        rRXU/xNpCckDqOXMH5AIwcMnQaXz0dQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-NeysvbJNM_mOZDG51GPGMg-1; Thu, 18 Jun 2020 05:58:26 -0400
X-MC-Unique: NeysvbJNM_mOZDG51GPGMg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC42485DA2C;
        Thu, 18 Jun 2020 09:58:24 +0000 (UTC)
Received: from [10.72.13.252] (ovpn-13-252.pek2.redhat.com [10.72.13.252])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B81211000324;
        Thu, 18 Jun 2020 09:58:17 +0000 (UTC)
Subject: Re: [PATCH v2] kexec: Do not verify the signature without the
 lockdown or mandatory signature
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        ebiederm@xmission.com, jbohac@suse.cz, jmorris@namei.org,
        mjg59@google.com, dyoung@redhat.com, bhe@redhat.com
References: <20200602045952.27487-1-lijiang@redhat.com>
 <20200617123731.0dbb039a053a2ef610af59fb@linux-foundation.org>
From:   lijiang <lijiang@redhat.com>
Message-ID: <d10e6b33-e41f-f3be-4aaa-8ffa22a1cc29@redhat.com>
Date:   Thu, 18 Jun 2020 17:58:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200617123731.0dbb039a053a2ef610af59fb@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020年06月18日 03:37, Andrew Morton 写道:
> On Tue,  2 Jun 2020 12:59:52 +0800 Lianbo Jiang <lijiang@redhat.com> wrote:
> 
>> Signature verification is an important security feature, to protect
>> system from being attacked with a kernel of unknown origin. Kexec
>> rebooting is a way to replace the running kernel, hence need be
>> secured carefully.
> 
> I'm finding this changelog quite hard to understand,
> 
Thanks for your comment.

I will improve the patch log and try to make it easily understand.

>> In the current code of handling signature verification of kexec kernel,
>> the logic is very twisted. It mixes signature verification, IMA signature
>> appraising and kexec lockdown.
>>
>> If there is no KEXEC_SIG_FORCE, kexec kernel image doesn't have one of
>> signature, the supported crypto, and key, we don't think this is wrong,
> 
> I think this is saying that in the absence of KEXEC_SIG_FORCE and if
> the signature/crypto/key are all incorrect, the kexec still succeeds,
> but it should not.
> 
When the KEXEC_SIG_FORCE is not enabled, even if kexec kernel image doesn't
have the signature, or the key, etc, kexec should be still allowed to loaded,
unless kexec lockdown is executed.

>> Unless kexec lockdown is executed. IMA is considered as another kind of
>> signature appraising method.
>>
>> If kexec kernel image has signature/crypto/key, it has to go through the
>> signature verification and pass. Otherwise it's seen as verification
>> failure, and won't be loaded.
> 
> I don't know if this is describing the current situation or the
> post-patch situation.
> 
This is the current situation, and we'd like to change it so that kexec allows
the kernel and initrd images to be loaded when they are not the lockdown or 
mandatory signature.

>> Seems kexec kernel image with an unqualified signature is even worse than
>> those w/o signature at all, this sounds very unreasonable. E.g. If people
>> get a unsigned kernel to load, or a kernel signed with expired key, which
>> one is more dangerous?
>>
>> So, here, let's simplify the logic to improve code readability. If the
>> KEXEC_SIG_FORCE enabled or kexec lockdown enabled, signature verification
>> is mandated. Otherwise, we lift the bar for any kernel image.
> 
> I think the whole thing needs a rewrite.  Start out by fully describing
> the current situation.  THen describe what is wrong with it, and why. 
> Then describe the proposed change.  Or something along these lines.
> 
> The changelog should also make clear the end-user impact of the patch. 
> In sufficient detail for others to decide which kernel version(s)
> should be patched.  Your recommendations will also be valuable - which
> kernel version(s) do you think should be patched, and why?
> 

Currently, kernel will always verify the signature without the lockdown or
mandatory signature. This may prevent the kernel from loading the kernel and
initrd images via the kexec_file_load() syscall. However, we'd like to allow
to still load the images in such case rather than failure due to the signature
verification issue.

For example, at the stage of development and test, usually use a signature
key to test whether the procedure of signature can work well as expected.
Sometimes, the signing time may be expired, but still use the kernel with
the old signature key to reproduce some problems in some automatic tests,
which always caused the failure of loading images.

Let's clean the logic of kernel code and allow to still load the kernel and
initrd images without the lockdown or mandatory signature.


Hope this helps.

Thanks.
Lianbo

