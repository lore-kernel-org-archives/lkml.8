Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE94C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B99A620734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUF5zRNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbgFIRQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:16:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56542 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbgFIRQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591722974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yXdiOQv7NKIBd+DVRCSCXdbaCUEn9kqsC6k0oYzgv1w=;
        b=NUF5zRNznQMQhhJfvHhkudLAi4CSKM0Pl16k/fNINUCs23kNZkLBKqXzR7UnlGCdCkfapx
        sVMHYind71xL7hemN2xQbgvcbIIyxnienxb17FE7ZUv+TNz4NWPVW6+SE5elqJYiF6Ku/6
        OVykLBcfn4qd0hlNyN1wy+qwjpd3SYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-wXJTdLcZNqyNdx8RFUaYTA-1; Tue, 09 Jun 2020 13:16:09 -0400
X-MC-Unique: wXJTdLcZNqyNdx8RFUaYTA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B2A2801504;
        Tue,  9 Jun 2020 17:16:08 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B39625D9E4;
        Tue,  9 Jun 2020 17:15:58 +0000 (UTC)
Date:   Tue, 9 Jun 2020 13:15:55 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Steve Grubb <sgrubb@redhat.com>, linux-integrity@vger.kernel.org,
        linux-audit@redhat.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] IMA: Add audit log for failure conditions
Message-ID: <20200609171555.itbllvtgjdanbbk7@madcap2.tricolour.ca>
References: <20200608215343.4491-1-nramas@linux.microsoft.com>
 <27448076.Og45N0Lxmj@x2>
 <ada45440-aefd-a4b2-2a3b-c012872e86cb@linux.microsoft.com>
 <3776526.Vj75JV9fuy@x2>
 <518a51b7-6c8d-f55f-c73a-b15abae8e0af@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <518a51b7-6c8d-f55f-c73a-b15abae8e0af@linux.microsoft.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-09 10:00, Lakshmi Ramasubramanian wrote:
> On 6/9/20 9:43 AM, Steve Grubb wrote:
> 
> > > The number in parenthesis is the error code (such as ENOMEM, EINVAL,
> > > etc.) IMA uses this format for reporting TPM errors in one of the audit
> > > messages (In ima_add_template_entry()). I followed the same pattern.
> > > 
> > > Would it be better if the value for "cause" is formatted as
> > > 
> > >      cause=hashing_error_-22
> > > 
> > >      cause=alloc_entry_-12
> > 
> > Neither fit the name=value style that all other events follow. What would fit
> > the style is something like this:
> > 
> > cause=hashing_error  errno=-22
> > cause=alloc_entry errno=-12
> > 
> > Would this be OK? Also, errno is only to illustrate. You can name it
> > something else as long as there are no use case collisions with our
> > dictionary of field names.
> > 
> > https://github.com/linux-audit/audit-documentation/blob/master/specs/fields/
> > field-dictionary.csv
> 
> I am fine with this.
> 
> "errno" is currently not listed in the dictionary of audit message field
> names (Thanks for the pointer to this one Steve)
> 
> Mimi - please let me know if you have any concerns with adding the "result"
> code in "errno" field in integrity_audit_msg().

If it is added, it should be appended to the end of the record since it
is an existing record format, then in the case of res=1, errno= should
still be present (not swing in and out) and just contain zero.  (Or
another value if there is a non-fatal warning?)

> Sample message:
> 
> [    8.051937] audit: type=1804 audit(1591633422.365:8): pid=1 uid=0
> auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0
> op=measuring_keys cause=hashing_error errno=-22 comm="systemd"
> name=".builtin_trusted_keys" res=0
> 
> thanks,
>  -lakshmi

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

