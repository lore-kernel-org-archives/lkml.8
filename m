Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673FFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 405A220823
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGp6EKPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgGFX5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 19:57:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55695 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726805AbgGFX5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 19:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594079855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5h/pRXHkSxEq61rxonlUns+UKJmDH2+YzkyLNI3P18c=;
        b=aGp6EKPxAstW77DGe6ZmYhe2ZUC+5XcHTSyk+HH/uE0a0Ypcp0jVA+lScCxSuzRyxd0tdQ
        Tt0YW5cM3xkT9VWy+9eKjgS1fFqQ4gXVhDP2r+oc0+VHsR8yq5TGvhMChuuvFCk8rlAMp0
        hiGQJdrnnUkHhv8LXJzgRAChPb1fTZ4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-pTZlIE4oNFSUsG264xJT0w-1; Mon, 06 Jul 2020 19:57:31 -0400
X-MC-Unique: pTZlIE4oNFSUsG264xJT0w-1
Received: by mail-qv1-f70.google.com with SMTP id cv20so14988536qvb.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 16:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=5h/pRXHkSxEq61rxonlUns+UKJmDH2+YzkyLNI3P18c=;
        b=n6KcE4iMIfQFrdctiAsmpVE4sEG7lhMyQEPCFzYchdYkTqspUDQaAKEPhMbALf29WU
         NG/KQKFAf1ndalMSp6Kil3QknDIXcfX7X5D88B5ugBJVWzQkVGINpS5Eqr+lWKFqpZby
         hzi5lLILfLeUCQY5HfJnwSrOlkHyDw3p5GodoDH/XeOewQmYTpSLjOJwU6XqDttnIFWD
         fnj8UrdAzBcsFJGzDBOcOL5jRFD0+ylCpB+QmaXKRRgaxbYZskVFNF9/HeUfCY1KciZM
         UX3YUrWQnWa5m+Tx7V67dSgveZxKavXKY2Z3H2hm6x7Mj6zVHQtf/LeBDVuQZFj8fn5b
         KddA==
X-Gm-Message-State: AOAM533Gck7kSYHBLqk1Yta4IkggMQI0Ih0qfMAP0uTkXQMG5qZof304
        LK9c4Ti/AQhS57SuQyhyIK4rgLlkRt5EhOyoFRh7hr+uMWnbsRj6o5TIiJ6vuGdedpcywS7vvsW
        96QrB2byXfT7aMk5i4sPw4U6E
X-Received: by 2002:a37:a253:: with SMTP id l80mr49623332qke.197.1594079851023;
        Mon, 06 Jul 2020 16:57:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxr5SZNidI4OJoMWzUXi9Xjl/T41/3YcOx+9xtlh2k1eoNc3KkVBOU6fOs9TEw6tHZ9F9ixxA==
X-Received: by 2002:a37:a253:: with SMTP id l80mr49623312qke.197.1594079850724;
        Mon, 06 Jul 2020 16:57:30 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id g41sm25799385qtb.37.2020.07.06.16.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 16:57:30 -0700 (PDT)
References: <20200706181953.3592084-1-stefanb@linux.vnet.ibm.com> <20200706181953.3592084-3-stefanb@linux.vnet.ibm.com> <20200706230914.GC20770@linux.intel.com>
User-agent: mu4e 1.4.10; emacs 26.3
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 2/2] tpm: Add support for event log pointer found in TPM2 ACPI table
In-reply-to: <20200706230914.GC20770@linux.intel.com>
Date:   Mon, 06 Jul 2020 16:57:28 -0700
Message-ID: <87mu4cjixj.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jarkko Sakkinen @ 2020-07-06 16:09 MST:

> On Mon, Jul 06, 2020 at 02:19:53PM -0400, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>> 
>> In case a TPM2 is attached, search for a TPM2 ACPI table when trying
>> to get the event log from ACPI. If one is found, use it to get the
>> start and length of the log area. This allows non-UEFI systems, such
>> as SeaBIOS, to pass an event log when using a TPM2.
>> 
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>
> Do you think that QEMU with TPM 1.2 emulator turned on would be a viable
> way to test this?
>
> I'm anyway more worried about breaking existing TPM 1.2 functionality
> and that requires only QEMU without extras.
>
> /Jarkko

The 1.2 bits should be functionally the same as before, right?

