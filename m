Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC36CC33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 01:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BE224681
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 01:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="J6awDMxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgAOBim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 20:38:42 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:33692 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbgAOBim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 20:38:42 -0500
Received: by mail-qv1-f65.google.com with SMTP id z3so6681775qvn.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 17:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zB86OdZFDrWat1AGnvyuIwBegcKbZll1x1xYSmDEgvw=;
        b=J6awDMxYecnt2o/Ojvc3BCaWJnm0wq3PyYUA0Q7s3NSKA7dpqaEqjXV7QvnTO+tcj0
         osjESQGpLFAwWCTfbt7EghwM/AkRSxQ6Tkb/yiwCh64KrOvSN6SB1ZWzhXMzFgBg7zdH
         zTyxCZ4TE5c1dy6AbhDDud03KUX85INwQBAaiUmNVYSv+MiBbjmLGQGkTb5Tdg/Kfii+
         WXd7T1qqX0719Z79lW5Rbd8dMo5TIzdsDmPd+2vwm+raWCvSwh0RZ+pPj4rjOUEVvd3C
         YGkqEpt0ECWUIKnMZWnh+BVBk3mJpwfzla0aKxiVgvPXS7WN9NLq40yI/ahc0spCVFgS
         WOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zB86OdZFDrWat1AGnvyuIwBegcKbZll1x1xYSmDEgvw=;
        b=qHM3/y/oUhF3byVl2Ui/QzLl3zMb0d/uMy0odfAUCcWVjg26P6UOLld5Mwcg4Dufok
         y4Po29D+bRadvvORdsAhOFPXci2FWvWu7RcKMg7b82l3AQk2MDq6xKGQ3aH2g29G6UMj
         lFdcmAxyFe9Qk3a8P6ssBkvhuU/CodS/RLwxAbOrg1syRzsTL+aY4SMU8ofpaK89CzPd
         8wpj09Vz/Cf76NRZ0zIrE+ZKD0vRFgCOPKU2ZxBLaVM4dPOQOmb8HSAguaMlbbb/yRMq
         XG7CMSw/njt/mHN/Bu5eCqiihvdRLFX+hkawO4h5iCtlysqLU7Pc1St9/EUw3XQJhCIC
         1smg==
X-Gm-Message-State: APjAAAVtO9aVFfrvIvk+3UFF+YPfKzS35hkpUQMC7QCaSdlz1ufSJF35
        07QykAe43skHE/ZRoRnKLjMTCQ==
X-Google-Smtp-Source: APXvYqzJ84dtMmg3ZNWCYkkPbnG5iYq6NVXEmRYeD5xzvGgvM9WqH9u7M2ObrVuC8kJYy1hijwtLrg==
X-Received: by 2002:a0c:d60e:: with SMTP id c14mr19493095qvj.76.1579052321155;
        Tue, 14 Jan 2020 17:38:41 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 13sm7574112qke.85.2020.01.14.17.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jan 2020 17:38:40 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH -next] mm/hotplug: silence a lockdep splat with printk()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200114171930.9a0dbd9ae82174abf19b3df5@linux-foundation.org>
Date:   Tue, 14 Jan 2020 20:38:39 -0500
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8093D190-00C7-43A7-B63E-E06A80D20094@lca.pw>
References: <20200114210215.GQ19428@dhcp22.suse.cz>
 <D5CC7C52-1F08-401E-BDCA-DF617909BB9D@lca.pw>
 <20200114155339.ad5eee63b9ff38b617ee6168@linux-foundation.org>
 <DEF43337-68A2-4FDF-9B8C-795E017831DE@lca.pw>
 <20200114171930.9a0dbd9ae82174abf19b3df5@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 14, 2020, at 8:19 PM, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Tue, 14 Jan 2020 20:02:31 -0500 Qian Cai <cai@lca.pw> wrote:
>=20
>>=20
>>=20
>>>> @@ -8290,8 +8290,10 @@ bool has_unmovable_pages(struct zone *zo
>>>> 	return false;
>>>> unmovable:
>>>> 	WARN_ON_ONCE(zone_idx(zone) =3D=3D ZONE_MOVABLE);
>>>> -	if (flags & REPORT_FAILURE)
>>>> -		dump_page(pfn_to_page(pfn + iter), reason);
>>>> +	if (flags & REPORT_FAILURE) {
>>>> +		page =3D pfn_to_page(pfn + iter);
>>>=20
>>> This statement appears to be unnecessary.
>>=20
>> dump_page() in set_migratetype_isolate() needs that =E2=80=9Cpage=E2=80=
=9D.
>=20
> local var `page' is never used after this statement.
>=20

The goal is to reuse the parameter of has_unmovable_pages((=E2=80=A6, =
page, =E2=80=A6)
as a return value, so after it returns, dump_page(page, ...) could use =
it. I
don=E2=80=99t see where it was defined as a local variable.

This is probably a bit too hacky, so I=E2=80=99ll change =
has_unmovable_pages()
to either return "struct page *=E2=80=9D or NULL which is easier to =
understand.=
