Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB28C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 13:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA2D20716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 13:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="r8gm/AdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgC1NVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 09:21:00 -0400
Received: from mout.web.de ([212.227.17.12]:47313 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgC1NU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 09:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585401629;
        bh=rj2dd/wjjs0wZXHVMt2SNgMAMS9Kg01REUj+2iSXFgk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=r8gm/AdIVZy5N3uuJAvUjVnd+jTkzFrqVYdOF9N1yA5pk1a/ZY8LAclnobpIlQ+iy
         dKT+lQtXLc8CZ5SmnYNLnLb58Z0RO4B5Kn7q7N0l7JED8E1hZx8eNLy4Hfca1sWSuI
         3REtXq9svf6SQUbNmstJurJNSsx/EhJaTxnEK+1w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.150.134]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MbhRh-1iz8Qq1dmH-00J6kX; Sat, 28
 Mar 2020 14:20:29 +0100
Subject: Re: [v3 05/10] mmap locking API: Checking the Coccinelle software
To:     Michel Lespinasse <walken@google.com>,
        Coccinelle <cocci@systeme.lip6.fr>, linux-mm@kvack.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200327225102.25061-1-walken@google.com>
 <20200327225102.25061-6-walken@google.com>
 <bc2980d7-b823-2fff-d29c-57dcbc9aaf27@web.de>
 <CANN689H=tjNi=g6M776qo8inr+OfAu8mtL5xsJpu4F=dB6R9zA@mail.gmail.com>
 <3c222f3c-c8e2-660a-a348-5f3583e7e036@web.de>
 <CANN689HyS0dYWZw3AeWGBvN6_2G4hRDzjMJQ_adHMh0ZkiACYg@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <590dbec7-341a-3480-dd47-cb3c65b023c7@web.de>
Date:   Sat, 28 Mar 2020 14:20:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CANN689HyS0dYWZw3AeWGBvN6_2G4hRDzjMJQ_adHMh0ZkiACYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:krbC0XFGa385Kjo9pxo5U54N1FmWK5puPPB1GSe/MEB5OLSx8GW
 MW80X+Aho2WIaI+n/PvfIYBXF8u/Tv5z/NW+K4Omdeq4jHxIIim9pFRP2JrIJ+qi7qgbAEF
 mKlyyCBl7NO/TLaf2bltytPvGUEh8+68U1UaZXL2ikUCVPL+D24tTZrd0FtaIbdR59B6fX/
 lXYPTihMgMnNK5nVAq7dQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y/n4N8BC5HQ=:24Ol3SKeOfQxs0l7dRggc2
 zufmRmWmcr6qJmFYbXj0/DOazd1cWqjiNq6ymipdbvf0k0H4QMepI0avYk+eTCCLCCqW7LyJP
 lnKxx2zBeXu4HB+ZRFP3NW9Wh230bNOZ2uQwpgbyAGytzsmSBtZmKjPXQSs8G+3WY1GRSLmQq
 tCoSuHE+MhI2frAt3KBw3Ub4kfGN/ftY70QAnTQSvl5EhfQnHAfD0hXVOYIyRG9ifOCwh5Stt
 om99sHKxiP1tI+S8tMzAZ7YK3InwI5fMFzc78vVacHuhudTQSzVtgwqD+B3LHSWfNw8ZyAUki
 HR2uD9SBaSEkDYLWtzvJ86JlQ0ILpC059vsUb4+WUxFDeJbh/MyhQyYFNWOr1CPGyG1S+m2zL
 uBUjwGTQJsxNU2E5Tf/aRYqdDtgyTJIgwpFajvnTowODvDePbVqR6K5wFxf3Y86uKVLtrll4+
 C09rJzpB5swZKIfy2gnp0mNes4O7Myvz+8liXyRIua5izZSEADcBfzNnacashxR93G0h0Hx0h
 PdzgQVBz02o9LwnFy+zRnpq4LVL9piCf4NOw9b/SkdVkM/v0/e4l/6PRzf6CutSY8bhjj9CNm
 zytroB3ATwXzMQEmqBwuW4tWKh/uHp4HwJT+ObhCmAkwQF9nbeOLFM+ky2WyKgELwzTfYmqdE
 IETKmQF4IZfbLbsDr3ghgbki67dAH4UsemTrH18YwS7gWtBv3EDnM+P9YHobBnFboxzuc06WK
 9XbfCSmpdztst+woOXwIZUxVUaf7qbVu5WuIRqZx0SE/fHPUMCCPhAFy8ro4sMKtLGyXjH/WE
 4HDQkfSQTSmVQaBk/BFw/n1PJH86SA1TMyh/R0uS0rD+or3Y9RaSVUBl/b8sTbLnIzMvylvpA
 3/lDW+6KgaYPWD2CNYK/zmHBRKTQJaFo64MATHVwlB4RL2MHeHNKMW92HzYPmstEPIZ9wx7Zm
 3U2cNCSLPuKNBlIicPDJL+7YrpD1O1yi0/WPzjsNoNruaEQTqWCykLzqDIJUoVhcS+Onsmuk3
 6lAihjR1WW6mJ91f9KaIsbJey/8BmP3SLsWFuJFgv/igGR4fA6O8PSWk7KaPkX/jlzpkg5wG1
 gTm5vtIVVSjVZrq7X+44WgcNT7NB2eSm1OPfDgpu8KM7gpMPk+Rxqsq7qyCxQCNWBnWhf6hVg
 0uQZa42q/Zo2mAJ3HDjcEwfg/cmxpeZ0Xb3iiPp8eIOqudYVcpLPV8dUj4jSyRgnohGIVGtV6
 RSApBNHDC1oSP8XO2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> How will corresponding software development resources evolve?
>
> I don't think I understand the question, or, actually, are you asking
> me or the coccinelle developers ?

I hope that another communication approach can eventually increase
the chances for a better common understanding of development challenges.

The code from a mentioned source file can be reduced to the following
test file.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/ar=
ch/mips/mm/fault.c?id=3D69c5eea3128e775fd3c70ecf0098105d96dee330#n34

// deleted part
static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long =
write,
	unsigned long address)
{
	struct vm_area_struct * vma =3D NULL;
	struct task_struct *tsk =3D current;
	struct mm_struct *mm =3D tsk->mm;
// deleted part
retry:
	down_read(&mm->mmap_sem);
	vma =3D find_vma(mm, address);
	if (!vma)
		goto bad_area;
// deleted part
}
// deleted part


Application of the software =E2=80=9CCoccinelle 1.0.8-00029-ga549b9f0=E2=
=80=9D (OCaml 4.10.0)

elfring@Sonne:~/Projekte/Coccinelle/Probe> spatch --parse-c do_page_fault-=
excerpt3.c
=E2=80=A6
NB total files =3D 1; perfect =3D 1; pbs =3D 0; timeout =3D 0; =3D=3D=3D=
=3D=3D=3D=3D=3D=3D> 100%
nb good =3D 15,  nb passed =3D 1 =3D=3D=3D=3D=3D=3D=3D=3D=3D> 6.25% passed
nb good =3D 15,  nb bad =3D 0 =3D=3D=3D=3D=3D=3D=3D=3D=3D> 100.00% good or=
 passed


The discussed transformation approach can also be reduced for a test
to the following script for the semantic patch language.

@replacement@
expression x;
@@
-down_read
+mmap_read_lock
 (
- &
  x
- ->mmap_sem
 )


elfring@Sonne:~/Projekte/Coccinelle/Probe> spatch use_mmap_locking_API_3.c=
occi do_page_fault-excerpt3.c


The desired diff is not generated so far.
How would you like to fix this situation?

Regards,
Markus
