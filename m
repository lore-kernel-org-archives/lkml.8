Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B481FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 03:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9550920575
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 03:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk55K9y+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgEND7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 23:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgEND7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 23:59:51 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52CBC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 20:59:51 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e8so849535ilm.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 20:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=YZN2rOoBZ7nT13bfGnDLSFWTXQ68hHNsIaIBGs4FzxA=;
        b=Kk55K9y+dNoJqW1fYQute2yGbQCoNfUnfQl7TfnwNWZq/Q9Sz6vWRC9keNQ/QcwfP5
         Fkd9FlUlJieCEl/lsifD2gPEewl9ggqJCUXZhReeHJHtNOw/g0nG4ITgkzuD7Crq56CQ
         6ORo4Q1ovb6JzpVMSqMPGFF0EHCzB6p/liCk+Vqw6I1oBZtgo0oFdzA9hnNSzbxLB4Nt
         UiLv9SuD6IKby/xi9UTyeSfxYmzJ3kV1ZZia35egdO7ba1papXdqWaZC1xmf/7U4j0A5
         PGSurLBcD4s89DIUmc5B86UyZER5wdtiyKVwkQFaEHPnHJ8ITsFVqSKRfmHMvVHF3lqr
         CBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=YZN2rOoBZ7nT13bfGnDLSFWTXQ68hHNsIaIBGs4FzxA=;
        b=b5RfTBe2UdnRb54WZnsNYgsxiRSqdU54VMyqx2qI7KLvfGQZPeRp8OEVLlV5ha8baA
         52EilVXANueJ1K8W7B9x+RSz9PwKmZ6Hu1XycWEpNcnLiDGu2idYvC2UujeqJGnA14cP
         vpXDUUfnLKYZn7mGXcLYD/IlBH0HwpkbLl3A/uqr5U66BZhPqKt/Td+o1UiKsNMyjVgh
         qSvIbLzwSqTeCX0Mgqdz9ea/+W01mnFATo1HW6OP/fapJPRyolcz+VdgPvY/5Qren516
         3f/vioNk8jt9zCpc34n/okR9MWCfs1JYVlMbi/qJpWmlu/8TLp1KVZna2Gr9d+jCkQ0o
         5Hcw==
X-Gm-Message-State: AOAM532LWB8lb7KOuD0J05qk2Oe7eutSsMRgrVYXIAXmmRiVK251JOpP
        DJD5ptpWA2oyxIVGYVdIRCz2V3nFpiaDz1SxeCveOw==
X-Google-Smtp-Source: ABdhPJw//dfWS/EXrT9Nn6uLKmeFVfbfqzS9Og8hJp5yIv6MxlLE/Vo3lUp7gIYqItBAeMb5sfNnwha/qcD33dabHIE=
X-Received: by 2002:a92:d186:: with SMTP id z6mr2715190ilz.119.1589428789890;
 Wed, 13 May 2020 20:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAFSR4csC1u8UVga3JjqN2w2D25NeboKxgWVs5LjAN+Zgyq+_pQ@mail.gmail.com>
In-Reply-To: <CAFSR4csC1u8UVga3JjqN2w2D25NeboKxgWVs5LjAN+Zgyq+_pQ@mail.gmail.com>
From:   Dongyang Zhan <zdyzztq@gmail.com>
Date:   Thu, 14 May 2020 11:59:42 +0800
Message-ID: <CAFSR4ctk4PgMcLGTx6Q7K2DzF+efpG2irnBcod1HZTEH7i6tRg@mail.gmail.com>
Subject: Fwd: Possible null pointer dereference caused by vmstat_start()
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A Dongyang Zhan <zdyzztq@gmail.com>
Date: 2020=E5=B9=B45=E6=9C=883=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=
=881:45
Subject: Possible null pointer dereference caused by vmstat_start()
To: <fenghua.yu@intel.com>
Cc: <linux-kernel@vger.kernel.org>


In Linux 4.10.17, vmstat_start() stores the results of v =3D
kmalloc(stat_items_size, GFP_KERNEL) in m->private =3D v before security
check. If m->private is accessed, it may cause null pointer
dereference.

Source code link:
https://elixir.bootlin.com/linux/v4.10.17/source/mm/vmstat.c#L1465

Source code;
v =3D kmalloc(stat_items_size, GFP_KERNEL);
m->private =3D v; //stores v before check;
if (!v)
 return ERR_PTR(-ENOMEM);

Function rdtgroup_seqfile_show() in
arch/x86/kernel/cpu/intel_rdt_rdtgroup.c access this pointer without
check, which is a possible bug.

Link:
https://elixir.bootlin.com/linux/v4.10.17/source/arch/x86/kernel/cpu/intel_=
rdt_rdtgroup.c#150
Source Code
static int rdtgroup_seqfile_show(struct seq_file *m, void *arg)
{
struct kernfs_open_file *of =3D m->private;
struct rftype *rft =3D of->kn->priv; // without check;

if (rft->seq_show)
return rft->seq_show(of, m, arg);
return 0;
}
