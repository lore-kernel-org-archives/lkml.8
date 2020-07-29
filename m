Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5F1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7D232075F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KR9JPPMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgG2Slk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:41:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45378 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726365AbgG2Slj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 14:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596048098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TG0mMl+qERD/p/lH0bBKbEKr9d96L0uZ7lfwhkdYZqA=;
        b=KR9JPPMalS+NrTCHv0L7YpRCDe8thzUfMKv5JtR1yWWw+FI3wTqp7yl2AuEQKWAyuaTyGe
        EB/qZU1yQKeBaHI7XYsW5uT1axGanapjf4RPoQdxbblEwmlTTboOVHnxROuN5zrhmQkT7/
        jM3R56oZhASXGGmYPq+B4oknrDA5d70=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-Q3tWcsCuNf-1NJvSkpAWEg-1; Wed, 29 Jul 2020 14:41:37 -0400
X-MC-Unique: Q3tWcsCuNf-1NJvSkpAWEg-1
Received: by mail-ej1-f72.google.com with SMTP id d16so8875051eje.20
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 11:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=TG0mMl+qERD/p/lH0bBKbEKr9d96L0uZ7lfwhkdYZqA=;
        b=AqLbipGNr+VkTm0dTYYdazfR6rYFZnZIcd4NDYuuhY3r3KgCkaEQ284WpUihZsQfH6
         VukpZ47H18Ccay6FExnjg2rBYbPysO/HSQiW+XKvxkp+SaSyjz4aH2avCTEG8NBtIWLH
         6JFdBXwZd1aECoLPqLsFYEBL2SKpFvhbZoXaEHgCQJTH97eEnz3Se3rCrXr/+SbAi2NU
         uxERLvcwGjnwHYEdxcMz+u/utYK5XhdbpXfKyX5OAubnnji6nQ/ocn3Gd6Tk8T2WcQpi
         OyzB89nSp+/080hzcndzyOwBEfEBPHwrbxp+ymsdVS9zbHf1IalxmFSJv/uN34eE3Ac8
         rXjw==
X-Gm-Message-State: AOAM531oFIO0XkgGaFQj8UbvCcy5gGnLDxVM6W6uoVTKluNsSVNjSKOq
        TMILUpjRL5ch7xdAmfnRZzlO1DyTUkR395VRSX6fdRhMJkMcUq+ZfbMtxgFeYPO/OeWwOYPvQAc
        eWVRfMTAwLBabz/KJvI2+KR09
X-Received: by 2002:a17:906:57da:: with SMTP id u26mr32850947ejr.157.1596048095906;
        Wed, 29 Jul 2020 11:41:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqBeHBARqfws6XTYi+Qge5cssgBVDY+eGXTA2/OoOf8zdNHETw9pWTyLkfcSfSO7LFjj/Y7A==
X-Received: by 2002:a17:906:57da:: with SMTP id u26mr32850934ejr.157.1596048095726;
        Wed, 29 Jul 2020 11:41:35 -0700 (PDT)
Received: from [192.168.3.122] (p5b0c648d.dip0.t-ipconnect.de. [91.12.100.141])
        by smtp.gmail.com with ESMTPSA id k22sm2675294edo.24.2020.07.29.11.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 11:41:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 2/6] mm/page_isolation: don't dump_page(NULL) in set_migratetype_isolate()
Date:   Wed, 29 Jul 2020 20:41:34 +0200
Message-Id: <8EDC210B-0A0F-4FAC-B008-303CE2D65A26@redhat.com>
References: <79240e7f-de16-aee6-fbf6-07e7f184a924@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S.Tsirkin" <mst@redhat.com>
In-Reply-To: <79240e7f-de16-aee6-fbf6-07e7f184a924@oracle.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 29.07.2020 um 20:36 schrieb Mike Kravetz <mike.kravetz@oracle.com>:
>=20
> =EF=BB=BFOn 7/29/20 11:08 AM, David Hildenbrand wrote:
>> I have no clue what you mean with "reintroducing this abandoning of
>> pageblocks". All this patch is changing is not doing the dump_page() -
>> or am I missing something important?
>=20
> My apologies!!!
>=20

No worries, thanks for reviewing!!

> I got confused when I saw 'Return -EBUSY' removed from the comment and
> assumed the code would not return an error code.  The code now more
> explicitly does return -EBUSY.  My concern was when I incorrectly thought
> you were removing the error return code.  Sorry for the noise.
>=20
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> --=20
> Mike Kravetz
>=20

