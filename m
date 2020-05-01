Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679ACC35280
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AB1D2166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgEAUas convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 16:30:48 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:35637 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAUar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:30:47 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MXY6b-1jfSqQ0kut-00Z0q4 for <linux-kernel@vger.kernel.org>; Fri, 01 May
 2020 22:30:45 +0200
Received: by mail-qt1-f178.google.com with SMTP id g16so4929286qtp.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 13:30:44 -0700 (PDT)
X-Gm-Message-State: AGi0PuYZ13p8LsNIz+DtlLaSE1jJTwY2lAynRkrVaK0sj80GjIk4De8K
        o3pITe3m9DFQvAfxkGTn5xfiI897zy/hRqTgzXI=
X-Google-Smtp-Source: APiQypJtprYFko430qql/hXdVN4hcrw6bhVhXNdrigj1vMHLkxccdqpReLVKoRWzl0oGcVculKuhoTuniXqtw1le3a0=
X-Received: by 2002:ac8:4c8d:: with SMTP id j13mr5652562qtv.142.1588365043964;
 Fri, 01 May 2020 13:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200430213101.135134-1-arnd@arndb.de> <20200430213101.135134-10-arnd@arndb.de>
 <20200430215450.anfwm4zikvhy2bt5@pali>
In-Reply-To: <20200430215450.anfwm4zikvhy2bt5@pali>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 1 May 2020 22:30:27 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0_BuKDK7X8dTHyx7t++CGjy3jhDVvL=Jo5=kcUxmtobg@mail.gmail.com>
Message-ID: <CAK8P3a0_BuKDK7X8dTHyx7t++CGjy3jhDVvL=Jo5=kcUxmtobg@mail.gmail.com>
Subject: Re: [PATCH 09/15] udf: avoid gcc-10 zero-length-bounds warnings
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Steven J. Magnani" <steve@digidescorp.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:hyYHBsnCjTw2RsqXW0udu3soGToIo8aCsKt5tPa+Z384npvvaUU
 0HqAxJMCRma9tqyEPgxdd7qT4P1hSbQ1pRnaORRScMYZ2m4YB6WMvDI4jM7dWoGDSys0mZ3
 JDMQInd+KKiBGtJvlcQ8KD1bcESxbXQfGt82yWoTGHnDJSmk+IhH33A9j57j28f1lupFbry
 jzG2Va/Iebfm3qjJ0TLsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1dVNIjVhzy0=:4srgdZGaY/dgKexA0AHZhN
 ZWHxnYf/BpmnU7y7EKqW5gs9SAZ/UuXmkBdACuX9fHxSoIP3XnDRep3UMsOnmMlVwISTEmiV0
 +q3x+Vzh9cPUdZzw3g/CKFca9ITXGEq/WQDl88JdFz6n0XYg0he/vBy3aZIG+PSHEnu4XMWUu
 9yT0n6RkIbbOP0S8wBgPuVoE0djFl7nz5GQfSCy85w3V0dPFkAZ0hTEl7cnluk+ZWdpOa6JAW
 olxoSKkJnTU0b7Xu2BWruL0NFNkXyFfhBAenyqwp7pNYC0+VYtkqpoifLzY+nbZAZesSl6KYk
 gDRIWqnsi1KAhxqhnUtTysEzwMwji3lxE+/gL07WeauStEK0BHGsbzB2sumRdLvIpq6mT1GXC
 O8Kvw8Hz1j5GN0vUfGuhA/7sEK9rkl3CMnwskqpK5L+ewLR+BDKxjs8Ob63yhr2AHuAS/XlAg
 zswJ5nIqZkgdlIgwGgz+CHYToAAKGRo9rq6X8xcCE+ceMwsy/k3rWbIP0aYd8vwlDFvIcBgQ4
 UkzdDM841ktTroF/rBNzYvlrQm+BQypLa7ZxuvtFCE8FlgJY8LVpdA1WQZRcZzFQrZFcMtOsr
 QovoJn90NIMSW0kJfzXF1TPia4fsuqZENmh9P/c7l38RNMFjPG294lJ82EgISUkbrBvcE+k8h
 d5im1GDY8NHPxA65qLXcnCOTl6BciRfO/dX7r+7oR/QWNQ3ueLIiRNmCAlO840HDpxbxkQukq
 E/jkfUyJzTh6L+ls6ITljE2wS/LoUiCaGhfUzeGcJIguXP0YrlJZppo5r/7MZ7/KWsv8NvTfB
 Nio1sbhqGIWAIwU1ucWD5XZWYvwZ7+1HaiAt4KZQRpKeF4yXtU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 11:54 PM Pali Rohár <pali@kernel.org> wrote:
>
> On Thursday 30 April 2020 23:30:51 Arnd Bergmann wrote:
> > gcc-10 warns about writes to the empty freeSpaceTable[] array, with
> > many instances like:
> >
> > fs/udf/balloc.c: In function 'udf_bitmap_new_block':
> > fs/udf/balloc.c:101:36: error: array subscript 65535 is outside the bounds of an interior zero-length array '__le32[0]' {aka 'unsigned int[0]'} [-Werror=zero-length-bounds]
> >   101 |  le32_add_cpu(&lvid->freeSpaceTable[partition], cnt);
> >       |                ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
> > In file included from fs/udf/udfdecl.h:7,
> >                  from fs/udf/balloc.c:22:
> > fs/udf/ecma_167.h:363:11: note: while referencing 'freeSpaceTable'
> >   363 |  __le32   freeSpaceTable[0];
> >       |           ^~~~~~~~~~~~~~
>
> Hi Arnd! This looks like a false-positive warning.

Right, sorry for not making that clearer in the changelog.

> > These can all be avoided by using a flexible array member instead.
> >
> > Another warning is a bit more obscure:
> >
> > fs/udf/super.c: In function 'udf_count_free':
> > fs/udf/super.c:2521:26: warning: array subscript '(<unknown>) + 4294967295' is outside the bounds of an interior zero-length array '__le32[0]' {aka 'unsigned int[0]'} [-Wzero-length-bounds]
> >  2521 |      lvid->freeSpaceTable[part]);
> >
> > Work around this one by changing the array access to equivalent
> > pointer arithmetic, as there cannot be multiple flexible-array
> > members in a single struct.
>

> > @@ -360,9 +360,9 @@ struct logicalVolIntegrityDesc {
> >       uint8_t                 logicalVolContentsUse[32];
> >       __le32                  numOfPartitions;
> >       __le32                  lengthOfImpUse;
> > -     __le32                  freeSpaceTable[0];
> >       __le32                  sizeTable[0];
> >       uint8_t                 impUse[0];
> > +     __le32                  freeSpaceTable[];
>
> Please do not change order of members in these structures. Order is
> strictly defined by ECMA 167 standard and changing them you would just
> confuse reader. In LVID is free space table before size table.

Ok

> If you do not like GNU C extension for zero-length arrays then just
> replace it by standard C99 flexible arrays. I think that there is no
> reason to not use standard C99 language constructions, just nobody had
> motivation or time to change (working) code.

No, the problem is that only the last member can be a flexible array,
so when impUse[] is the last member, freeSpaceTable has to be a zero
length array.

[]> Also this file is semi-synchronized with udftools project in which I
> already replaced all GNU C zero-length arrays by C99 flexible arrays.
>
> You can take inspiration what I did with logicalVolIntegrityDesc:
> https://github.com/pali/udftools/commit/f851d84478ce881d516a76018745fa163f803880#diff-1e1a5b89f620d380f22b973f9449aeaeL381-R384

Right, this is likely the best workaround.

> Anyway, if you have a better idea what to do with such on-disk structure
> and how to represent it in C struct syntax, let me know as it could be
> updated also in udftools project.

The trick I used for impUse[] would also work for freeSpaceTable[] to avoid
the gcc warning, it's still not great, but maybe you like this better:

arnd@threadripper:~/arm-soc$ git diff
diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index 02f03fadb75b..666d022eb00b 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -98,7 +98,7 @@ static void udf_add_free_space(struct super_block
*sb, u16 partition, u32 cnt)
                return;

        lvid = (struct logicalVolIntegrityDesc *)sbi->s_lvid_bh->b_data;
-       le32_add_cpu(&lvid->freeSpaceTable[partition], cnt);
+       le32_add_cpu(lvid->freeSpaceTable + partition, cnt);
        udf_updated_lvid(sb);
 }

diff --git a/fs/udf/ecma_167.h b/fs/udf/ecma_167.h
index 14ffe27342bc..215d97d7edc4 100644
--- a/fs/udf/ecma_167.h
+++ b/fs/udf/ecma_167.h
@@ -360,9 +360,9 @@ struct logicalVolIntegrityDesc {
        uint8_t                 logicalVolContentsUse[32];
        __le32                  numOfPartitions;
        __le32                  lengthOfImpUse;
        __le32                  freeSpaceTable[0];
        __le32                  sizeTable[0];
-       uint8_t                 impUse[0];
+       uint8_t                 impUse[];
 } __packed;

 /* Integrity Type (ECMA 167r3 3/10.10.3) */
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 379867888c36..a1fc51c2261e 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -2517,8 +2517,8 @@ static unsigned int udf_count_free(struct super_block *sb)
                        (struct logicalVolIntegrityDesc *)
                        sbi->s_lvid_bh->b_data;
                if (le32_to_cpu(lvid->numOfPartitions) > part) {
-                       accum = le32_to_cpu(
-                                       lvid->freeSpaceTable[part]);
+                       accum = le32_to_cpup(
+                                       (lvid->freeSpaceTable + part));
                        if (accum == 0xFFFFFFFF)
                                accum = 0;
                }



This version could easily be backported to stable kernels to let them be
compiled with gcc-10, and then synchronizing with the udftools version of
the header needs additional changes on top, which do not need to be
backported.

       Arnd
