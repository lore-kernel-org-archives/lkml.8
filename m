Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3C4C47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A7F9206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PwsUNJU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbgEEPu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:50:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29351 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729828AbgEEPu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588693854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BU5ZQpCj0l/68xgDkpfBCKuLh4I4hSUfny0CTG25x9g=;
        b=PwsUNJU0ax5k3wvk+pBb0rx73cKtx/ITpKqJ0rh03h16PuRibD0QhzPnq9upkd14lA4WVm
        evS9mpD0YWRfGU7JsWlBKD3SOVnKyM4bNiHTb4lq78/aTM3n0uG11HfnTyJXiWRdekBTcW
        mAz+MKupSJZ4462LiJ6BF9zgT1ahiho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-OGdSBiARP6-UJlOyuB7bbA-1; Tue, 05 May 2020 11:50:50 -0400
X-MC-Unique: OGdSBiARP6-UJlOyuB7bbA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E64DD84E27B;
        Tue,  5 May 2020 15:50:46 +0000 (UTC)
Received: from llong.remote.csb (ovpn-114-81.rdu2.redhat.com [10.10.114.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A96775D9DA;
        Tue,  5 May 2020 15:50:45 +0000 (UTC)
Subject: Re: [PATCH] doc: Fix some typo errors in ras.rst
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200505151049.11134-1-longman@redhat.com>
 <20200505093258.77d052f5@lwn.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <2cb38bb2-bdb5-5fea-870a-ec92401ea374@redhat.com>
Date:   Tue, 5 May 2020 11:50:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200505093258.77d052f5@lwn.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/20 11:32 AM, Jonathan Corbet wrote:
> On Tue,  5 May 2020 11:10:49 -0400
> Waiman Long <longman@redhat.com> wrote:
>
>> Fix typo errors.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   Documentation/admin-guide/ras.rst | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/ras.rst b/Documentation/admin-guide/ras.rst
>> index 0310db624964..8b1803b2606f 100644
>> --- a/Documentation/admin-guide/ras.rst
>> +++ b/Documentation/admin-guide/ras.rst
>> @@ -156,10 +156,10 @@ the labels provided by the BIOS won't match the real ones.
>>   ECC memory
>>   ----------
>>   
>> -As mentioned on the previous section, ECC memory has extra bits to be
>> -used for error correction. So, on 64 bit systems, a memory module
>> -has 64 bits of *data width*, and 74 bits of *total width*. So, there are
>> -8 bits extra bits to be used for the error detection and correction
>> +As mentioned on the previous section, ECC memory has extra bits to
>> +be used for error correction. So, on 64 bit systems, a memory module
>> +has 64 bits of *data width*, and 72 bits of *total width*. So, there
>> +are 8 extra bits to be used for the error detection and correction
>>   mechanisms. Those extra bits are called *syndrome*\ [#f1]_\ [#f2]_.
> So I had to work to figure out what the change was, since you didn't say
> in the changelog and you refilled the paragraph.  But this looks like a
> *factual* error, giving the wrong number of bits, right?  It seems like
> the changelog should say that.  Do the people who know about this stuff
> agree that the change is correct?
>
> Thanks,
>
> jon
>
Yes, I change 74 bits to 72 bits and remove an extra "bits". Will send 
out v2 to clarify that.

Thanks,
Longman

