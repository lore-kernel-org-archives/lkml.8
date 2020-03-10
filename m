Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6C4C3F2D0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CE3222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlviqSyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgCJWDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 18:03:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47460 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726283AbgCJWDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583877783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=40W/kfQFw5xqXbXKZGwOTmPRgRjffptCSgf0Kp+g8OA=;
        b=GlviqSyhUvI2vgdzP0oDOE136jlcwDkyDy7bcz6Kvx5PvlRFmXlzK/ig/HbxaxRpE1eAQJ
        3sJzvdLOgsimRyPSrlu8OJrC36q2J7kuFYwVIQwyWNjN3crlEgXPpoGEhYnfWSmnFPEvvB
        TEuFkqBdf+JGbang79je28qoTfdf3jE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-jXbMTMIZNyaGkpWb0X8g1w-1; Tue, 10 Mar 2020 18:03:01 -0400
X-MC-Unique: jXbMTMIZNyaGkpWb0X8g1w-1
Received: by mail-wr1-f71.google.com with SMTP id t14so7360053wrs.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 15:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=40W/kfQFw5xqXbXKZGwOTmPRgRjffptCSgf0Kp+g8OA=;
        b=ORD3gkWY3UghogIhSV1xjiMFSxqC5woE42Pd1PpC5KvPNmcbjM3TBs3foD6TKlmkTx
         9QezgGyWxrthPF5wWBJzk81sFrsyEVLFhvmPBfV6q7O2xH+VLsop2vNFgcFEsIigg09Z
         B6lWmlzd2uqC2CDWgawAZBb0hAihvTaazKBsMUV8Ct4R1+ruTo0UU9xSmyeM3vclLlp6
         IOZAzEMgf+4oKlxjzSPLWNgzO4xUw6YIPSgP6lZ7dQoAfrtExSxHSdBHRSvW8NvKSBvE
         YUNY/HunyEUjRxN2dPAJ97YpV2tVydQY24jIMetnVc40VnISBZZind7iPJaKKdtlUZA7
         bCEQ==
X-Gm-Message-State: ANhLgQ3Bs0Bara8k6DTv67NXq8UIS6ksUXKdDsrt+QyGQhPCW78NxLP2
        r+JN48tKyum+XwLN7Nyve6nG6JEPLS37yk3F/AfBhhSbW2DntJt+hUDeeMosXyAGWMiaO53onoS
        exg3Z82U8zUHOrNngKo4dHl5R
X-Received: by 2002:a5d:4687:: with SMTP id u7mr15891897wrq.129.1583877780643;
        Tue, 10 Mar 2020 15:03:00 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtZW/8L6Ll/FpuR0abFGldY17cpkX73JNYI1cBMm+URNiyq/qfzVgh4k4hvqu/EPs8sL15bng==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr15891878wrq.129.1583877780451;
        Tue, 10 Mar 2020 15:03:00 -0700 (PDT)
Received: from [192.168.3.122] (p5B0C6338.dip0.t-ipconnect.de. [91.12.99.56])
        by smtp.gmail.com with ESMTPSA id u25sm5672417wml.17.2020.03.10.15.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 15:02:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] virtio-balloon: Switch back to OOM handler for VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Date:   Tue, 10 Mar 2020 23:02:58 +0100
Message-Id: <6021D755-F883-4524-B3D1-07C03C7DF11B@redhat.com>
References: <20200310172114-mutt-send-email-mst@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Tyler Sanderson <tysand@google.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Nadav Amit <namit@vmware.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20200310172114-mutt-send-email-mst@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 10.03.2020 um 22:25 schrieb Michael S. Tsirkin <mst@redhat.com>:
>=20
> =EF=BB=BFOn Tue, Mar 10, 2020 at 08:13:19PM +0100, David Hildenbrand wrote=
:
>>> Should this have:
>>>=20
>>> Cc: stable@vger.kernel.org # 4.19+
>>=20
>> I guess as nothing will actually "crash" it's not worth stable.
>=20
>=20
> No - it's a regression, it would be a stable candidate from that POV.

AFAIK

=E2=80=9E It must fix a problem that causes a build error (but not for thing=
s marked CONFIG_BROKEN), an oops, a hang, data corruption, a real security i=
ssue, or some =E2=80=9Coh, that=E2=80=99s not good=E2=80=9D issue. In short,=
 something critical.=E2=80=9C

If this regression is that critical is debatable. But it doesn=E2=80=98t mat=
ter as you correctly say, it=E2=80=98s too big :)=

