Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6494C3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A856220873
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KuG3UTL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgBKREf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:04:35 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25440 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728369AbgBKREe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581440673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+pVasLlAXrbuX/G7lTFwAzDA95FldSPgS2d9mYCqPyE=;
        b=KuG3UTL1zdh2oGpINOpXAhf4EM6NR7NDUrIeRg42jaXfO1d4A6A+QmkIU/L0t5wcWsxONJ
        2R6hQWEaSF4OxwPwlr2nqsXcFRJZvKemjz8pv35e0L5M4nzpyS1upvmUrQrZDkt8kBUTwS
        kcYwayf2PK6T8q0q9wdi8AA+2M7+dbA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-EN0lYfFzOHmffnIq9qCeHg-1; Tue, 11 Feb 2020 12:04:31 -0500
X-MC-Unique: EN0lYfFzOHmffnIq9qCeHg-1
Received: by mail-wm1-f70.google.com with SMTP id z7so1426167wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 09:04:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=+pVasLlAXrbuX/G7lTFwAzDA95FldSPgS2d9mYCqPyE=;
        b=TS5uOgFe0iQZOxLdo1wyMy+4VarnSER5fKkCR6UMCYzwezYogyiGYWFsHVnvLpvBbG
         vdx/7TtKtZiiYVpEic7ESnbx6VND6QcIFnZUcABUEd2tyct6H8NQ60bw7r75SIrGflcR
         LKaqSqqusLGaBhsHvwGHvU1r4iDG/lja8OMZppKa90Oxdu9x+/E8D2SmFWZyuVx5WxXJ
         vCpZVD8bBMhEkcSMatY9KYBvd1MA1Gv+vcuTlz2TCCEBapmovz9rjeMmzQ2Jfl8KpN4A
         G5JIA/A4ug09M0+6KVrY2VqJVJY59gMuAkXv4AAN8+ZwWTk7pcS7KwHAEHgk87STt0+1
         5q/w==
X-Gm-Message-State: APjAAAUdZTICXyW9bpSGFsyVYrLu6s1+8GNJYsjINEHcgURaNLU98p1n
        HjV+6NBvNcD2vKRfLZfUUAip47EDBTCPKUjyXzxgOMW/PHnkWdNLyT31bBVPN1SJVzdjR0oy24n
        fMksJApbhGoxXJ8QURhjbbrlN
X-Received: by 2002:a7b:c93a:: with SMTP id h26mr6919372wml.83.1581440670334;
        Tue, 11 Feb 2020 09:04:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqzMCDV526/z9R5lcDc3NhDo6UURiXu+j3B53PoBthyG7X0n2lAluIm3ooAEuX99NhH29t7P0w==
X-Received: by 2002:a7b:c93a:: with SMTP id h26mr6919325wml.83.1581440669937;
        Tue, 11 Feb 2020 09:04:29 -0800 (PST)
Received: from [192.168.3.122] (p5B0C67DC.dip0.t-ipconnect.de. [91.12.103.220])
        by smtp.gmail.com with ESMTPSA id j5sm6025280wrb.33.2020.02.11.09.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 09:04:29 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v16.1 6/9] virtio-balloon: Add support for providing free page reports to host
Date:   Tue, 11 Feb 2020 18:04:28 +0100
Message-Id: <B3E5574A-B696-4239-8F1D-ED51496DD59C@redhat.com>
References: <3a8d9e1a3a5528c3a0889448f2ffd02c186399b7.camel@linux.intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz, yang.zhang.wz@gmail.com, nitesh@redhat.com,
        konrad.wilk@oracle.com, pagupta@redhat.com, riel@surriel.com,
        lcapitulino@redhat.com, dave.hansen@intel.com,
        wei.w.wang@intel.com, aarcange@redhat.com, pbonzini@redhat.com,
        dan.j.williams@intel.com, osalvador@suse.de
In-Reply-To: <3a8d9e1a3a5528c3a0889448f2ffd02c186399b7.camel@linux.intel.com>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 11.02.2020 um 17:33 schrieb Alexander Duyck <alexander.h.duyck@linux.in=
tel.com>:
>=20
> =EF=BB=BFOn Tue, 2020-02-11 at 16:13 +0100, David Hildenbrand wrote:
>>>> AFAIKs, the guest could inflate/deflate (esp. temporarily) and
>>>> communicate via "actual" the actual balloon size as he sees it.
>>>=20
>>> OK so you want hinted but unused pages counted, and reported
>>> in "actual"? That's a vmexit before each page use ...
>>=20
>> No, not at all. I rather meant, that it is unclear how
>> inflation/deflation requests and "actual" *could* interact. Especially
>> if we would consider free page reporting as some way of inflation
>> (+immediate deflation) triggered by the guest. IMHO, we would not touch
>> "actual" in that case.
>>=20
>> But as I said, I am totally fine with keeping it as is in this patch.
>> IOW not glue free page reporting to inflation/deflation but let it act
>> like something different with its own semantics (and document these
>> properly).
>>=20
>=20
> Okay, so before I post v17 am I leaving the virtio-balloon changes as they=

> were then?

I=E2=80=98d say yes :)=

