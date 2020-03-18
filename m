Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63918C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9FA20770
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/KakLcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgCROeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:34:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:40683 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726789AbgCROen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 10:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584542082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UDcu1iOa70ydGTzbtxeciqeXori85SoY2pnI41cZUDY=;
        b=B/KakLcspf2zP1AY5YY7UdH40SAPbXWQwIS9RXl7d+rOxMWZjhHSDOvl0kI10L377PN+B7
        JpDBwAIKBVIQdcDMZyJ4sA9LDepsxC45Ub814p3Wx5Uk3RWYj1UQ2aCk14BWW351jD8XYV
        IOReVcNH40yNBupv0XBXhfieUvv0soM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-W8OgMNYEOw6rZG7yJQ1TWA-1; Wed, 18 Mar 2020 10:34:39 -0400
X-MC-Unique: W8OgMNYEOw6rZG7yJQ1TWA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D582C189D6C0;
        Wed, 18 Mar 2020 14:34:36 +0000 (UTC)
Received: from llong.remote.csb (ovpn-120-114.rdu2.redhat.com [10.10.120.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66E1D19C58;
        Wed, 18 Mar 2020 14:34:34 +0000 (UTC)
Subject: Re: [PATCH v4 4/4] KEYS: Avoid false positive ENOMEM error on key
 read
To:     David Howells <dhowells@redhat.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, netdev@vger.kernel.org,
        linux-afs@lists.infradead.org, Sumit Garg <sumit.garg@linaro.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Eric Biggers <ebiggers@google.com>,
        Chris von Recklinghausen <crecklin@redhat.com>
References: <20200317194140.6031-5-longman@redhat.com>
 <20200317194140.6031-1-longman@redhat.com>
 <2832139.1584520054@warthog.procyon.org.uk>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <e47bef56-9271-93e0-0e59-c77c253babea@redhat.com>
Date:   Wed, 18 Mar 2020 10:34:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <2832139.1584520054@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/20 4:27 AM, David Howells wrote:
> Waiman Long <longman@redhat.com> wrote:
>
>> +static inline void __kvzfree(const void *addr, size_t len)
>> +{
>> +	if (addr) {
>> +		memset((void *)addr, 0, len);
>> +		kvfree(addr);
>> +	}
>> +}
> I wonder if that would be better as "kvfree(memset(...))" as memset() will
> return the address parameter.  If memset is not inline, it avoids the need for
> the compiler to save the parameter.
>
> David

Doing this is micro-optimization. As the keys subsystem is that
performance critical, do we need to do that to save a cycle or two while
making the code a bit harder to read?

Cheers,
Longman

