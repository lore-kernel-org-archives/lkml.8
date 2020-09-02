Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F35C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 10:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 422B820829
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 10:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZoITomd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgIBKe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 06:34:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52018 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726167AbgIBKeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 06:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599042856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6YbE9ocgSEbs212dC/3NaXleeyro7z5HehKfcKWSbBA=;
        b=ZoITomd6BFf7vWxSJ5VKREoa7gtZvpLMWaTSVET2/NzMbsAaZyKeSVzmVreS14z2pOIWBr
        32p4Ekep2jhN+yRpYrUOCmzXsEWcPb3QyoeR77uqXDtKhhrgdKvkP82Q6bXBmkpcZyRud+
        gr1zmeWrLOAawe2+w88x/v4IUODECh0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-dQYtquTOPui_CH1XfYuaIw-1; Wed, 02 Sep 2020 06:34:15 -0400
X-MC-Unique: dQYtquTOPui_CH1XfYuaIw-1
Received: by mail-ej1-f71.google.com with SMTP id ml20so433655ejb.23
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 03:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=6YbE9ocgSEbs212dC/3NaXleeyro7z5HehKfcKWSbBA=;
        b=q92wHlN+piokyKP9X93QlC11LvvsRNsAiJvkdJbsoWB0TI8m+2hdy1B9yzfZO+fDJl
         PRh+GGnf9uJsvDnlU2dNNnj5sgwRu0cVr55nmMDbiDEITuKnMxmGHVn3vbTm7iWYgaQ4
         FXsl3KGsYGP+if+dpJgLrGtRNnyBfFwcNY6cX+tH885QqINiAFlUE5in+8b/Lw262rqV
         LhAxGcvEhZY5OzcjPsliEKMfayvNssS94jcMEWMfiaG2gZPe8pykeZDEPT8BA+6FFlLL
         GGvGITVFSvsbtRm5zKsdv6mpE91VMgd6uRJcehdb9x92KoSw96Xyl7apjY5GfRnwM4Bn
         26YA==
X-Gm-Message-State: AOAM530e7YVP5J2ucZZocwQeyd0s8qPqUMwBDk7Vg7lE9ZIdr0LL3Fs7
        BWtbfyqTU8MnxM2nqUy7mmpW/9pfWH/lKNC7zLeJeXhileTXKUDp2qH1fshglj6bFFEpWqMXPpl
        +T0WsQpK9Y8LL/jN3Q1Xvz5ug
X-Received: by 2002:a50:8e52:: with SMTP id 18mr5951902edx.28.1599042853984;
        Wed, 02 Sep 2020 03:34:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyfvB2OEfbLYHiQ0iuRWX5RnGHRm0NO4ryqac7O6KtUoD1XTteJLc6sk4G2sRZytr3cwXHFA==
X-Received: by 2002:a50:8e52:: with SMTP id 18mr5951872edx.28.1599042853725;
        Wed, 02 Sep 2020 03:34:13 -0700 (PDT)
Received: from ?IPv6:2003:c2:2f12:bb04:81d3:a22d:db7e:2eac? (p200300c22f12bb0481d3a22ddb7e2eac.dip0.t-ipconnect.de. [2003:c2:2f12:bb04:81d3:a22d:db7e:2eac])
        by smtp.gmail.com with ESMTPSA id x1sm3831470ejc.119.2020.09.02.03.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 03:34:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 4/5] xen/balloon: try to merge system ram resources
Date:   Wed, 2 Sep 2020 12:34:12 +0200
Message-Id: <24371321-8A12-4EBD-864C-A2B50E886BF7@redhat.com>
References: <226413fc-ef25-59bd-772f-79012fda0ee3@suse.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?utf-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        Julien Grall <julien@xen.org>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richardw.yang@linux.intel.com>
In-Reply-To: <226413fc-ef25-59bd-772f-79012fda0ee3@suse.com>
To:     =?utf-8?Q?J=C3=BCrgen_Gro=C3=9F?= <jgross@suse.com>
X-Mailer: iPhone Mail (17G68)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 02.09.2020 um 12:15 schrieb J=C3=BCrgen Gro=C3=9F <jgross@suse.com>:
>=20
> =EF=BB=BFOn 21.08.20 12:34, David Hildenbrand wrote:
>> Let's reuse the new mechanism to merge system ram resources below the
>> root. We are the only one hotplugging system ram (e.g., DIMMs don't apply=
),
>> so this is safe to be used.
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: Juergen Gross <jgross@suse.com>
>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>> Cc: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
>> Cc: Julien Grall <julien@xen.org>
>> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Wei Yang <richardw.yang@linux.intel.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  drivers/xen/balloon.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>> diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
>> index 37ffccda8bb87..5ec73f752b8a7 100644
>> --- a/drivers/xen/balloon.c
>> +++ b/drivers/xen/balloon.c
>> @@ -338,6 +338,10 @@ static enum bp_state reserve_additional_memory(void)=

>>      if (rc) {
>>          pr_warn("Cannot add additional memory (%i)\n", rc);
>>          goto err;
>> +    } else {
>> +        resource =3D NULL;
>> +        /* Try to reduce the number of system ram resources. */
>> +        merge_system_ram_resources(&iomem_resource);
>>      }
>=20
> I don't see the need for setting resource to NULL and to use an "else"
> clause here.
>=20

I set it to NULL because the pointer may be stale after that call - to avoid=
 future bugs. But I can drop it.

Ack to the =E2=80=9Eelse=E2=80=9C case.

Thanks for having a look!

>=20
> Juergen
>=20

