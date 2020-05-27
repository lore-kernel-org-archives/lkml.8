Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE363C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 04:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9042D2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 04:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUSb8iPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgE0EI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 00:08:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50363 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726907AbgE0EI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 00:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590552505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HNBN9I3GKdXmb2gltM0hVnCri1z/6RmaleZWAYCiNNc=;
        b=gUSb8iPiSV1yZCj2FGk9zYK9P3wsioZHPOCbPI7noTqaoybMDxuvHOEKER8n4C3lJUDw03
        bvA5WSQEChtWPPgi2yRKIyuKo/qgEmfVToWDNBTsr53EaVTJtiwEMBqAJ8CEWgNJfhuMgH
        raWbJWLNm2Nn2BRmFiqU3/bCqFxuOWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-KavK4lNnP42joJdk9iYHfQ-1; Wed, 27 May 2020 00:08:23 -0400
X-MC-Unique: KavK4lNnP42joJdk9iYHfQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C940E100A61D;
        Wed, 27 May 2020 04:08:21 +0000 (UTC)
Received: from [10.72.12.206] (ovpn-12-206.pek2.redhat.com [10.72.12.206])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC64D648DB;
        Wed, 27 May 2020 04:08:15 +0000 (UTC)
Subject: Re: [PATCH] kexec: Do not verify the signature without the lockdown
 or mandatory signature
From:   lijiang <lijiang@redhat.com>
To:     Jiri Bohac <jbohac@suse.cz>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        ebiederm@xmission.com, jmorris@namei.org, mjg59@google.com,
        dyoung@redhat.com, bhe@redhat.com
References: <20200525052351.24134-1-lijiang@redhat.com>
 <20200526135935.ffkfulsjf7xrep63@dwarf.suse.cz>
 <07a65a70-3764-f62f-705c-049b8d409316@redhat.com>
Message-ID: <4da44e94-a839-2033-29d2-90bebd4ee1e2@redhat.com>
Date:   Wed, 27 May 2020 12:08:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <07a65a70-3764-f62f-705c-049b8d409316@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020年05月27日 11:15, lijiang 写道:
> 在 2020年05月26日 21:59, Jiri Bohac 写道:
>> On Mon, May 25, 2020 at 01:23:51PM +0800, Lianbo Jiang wrote:
>>> So, here, let's simplify the logic to improve code readability. If the
>>> KEXEC_SIG_FORCE enabled or kexec lockdown enabled, signature verification
>>> is mandated. Otherwise, we lift the bar for any kernel image.
>>
>> I agree completely; in fact that was my intention when
>> introducing the code, but I got overruled about the return codes:
>> https://lore.kernel.org/lkml/20180119125425.l72meyyc2qtrriwe@dwarf.suse.cz/
>>
>> I like this simplification very much, except this part:
>>
>>> +	if (ret) {
>>> +		pr_debug("kernel signature verification failed (%d).\n", ret);
>>
>> ...
>>
>>> -		pr_notice("kernel signature verification failed (%d).\n", ret);
>>
>> I think the log level should stay at most PR_NOTICE when the
>> verification failure results in rejecting the kernel. Perhaps
>> even lower.
>>
> 
> Thank you for the comment, Jiri Bohac.
> 
> I like the idea of staying at most PR_NOTICE, but the pr_notice() will output
> some messages that kernel could want to ignore, such as the case you mentioned
> below.
> 
>> In case verification is not enforced and the failure is
>> ignored, KERN_DEBUG seems reasonable.
>>
> 
> Yes, good understanding. It seems that the pr_debug() is still a good option here?
> Any other thoughts?
> 

Or the following change looks better? What's your opinion?

static int
kimage_validate_signature(struct kimage *image)
{
        int ret;

        ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
                                           image->kernel_buf_len);
        if (ret) {

                if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
                        pr_notice("Enforced kernel signature verification failed (%d).\n", ret);
                        return ret;
                }

                /*
                 * If IMA is guaranteed to appraise a signature on the kexec
                 * image, permit it even if the kernel is otherwise locked
                 * down.
                 */
                if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
                    security_locked_down(LOCKDOWN_KEXEC))
                        return -EPERM;

                pr_debug("kernel signature verification failed (%d).\n", ret);
        }

        return 0;
}


Thanks.
Lianbo

> Thanks.
> Lianbo
> 
> 
>> Regards,
>>

