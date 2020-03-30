Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E249C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261852073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 06:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="CqUJaiP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgC3GLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 02:11:44 -0400
Received: from mout.web.de ([212.227.15.14]:39963 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgC3GLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 02:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585548669;
        bh=rgIa5/nptwT7LW3zkCGWC3qahXqpFaUN9hmXv9q+G24=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CqUJaiP6x2RXnejGpqcS2Oy8NYCVuq1Iqw793d0+QW7EfEJzqPUL+EEGqpQn5ArSi
         l7dJL50gyj+wkVUZ1mJTea6+hnuqnq1h04t7x6lvDtizDqfGfGrxb6OLOK3dGgjXXF
         bJigZb+Swmu+a3+83TnVWrrVIfe+bkhTdNyp5hRM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.71.255]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lp712-1ioyev1628-00et4w; Mon, 30
 Mar 2020 08:11:09 +0200
Subject: Re: [v3 05/10] mmap locking API: Improving the Coccinelle software
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
Message-ID: <2c74e465-249d-eeb8-86fe-462b93bfe743@web.de>
Date:   Mon, 30 Mar 2020 08:10:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CANN689HyS0dYWZw3AeWGBvN6_2G4hRDzjMJQ_adHMh0ZkiACYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zUr3lJ/NPVppiTc4eF5XDZJW52v9k/vHwHHOk2FuiNQ0rJzPPWt
 2vBRciOC1nvzY/uJlZz5H+IYA0h4qmZMk0pEomkS8TWhq5mjLLzlfdV/LQGLnFYkZ+PWAul
 I3EJdMGqI4d1ABmM2aMI+8xtq7m7KbNn36DyVIyvrjHntNrSty6UXFYZRkemL9MHtZjFtY/
 6MmYsW1Fdzi4Qp1qcvAGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NGEqitKj0HI=:pw68C8GodtwkdXTWt4mvfL
 9MYwWAkqqjQIgj6Joq59O4m6h4s2niWE2eF2YSSc//gP3r1YneF2zNxcO9vUnwfnrjbKnx+eq
 J1vRaWb88lZ7YKaQsmd/Evt/ry7VK8wL76Iy0AXqQBctNs9bc7Y7GV4rzc4IzQZ+0ELF22qqn
 hs6+B9vrkgXGSGRqe9Zp2AxQB/oy45xiJTR/KrfFhP8lKjXKYmcRwjy+yS2lWkn6EOG5RUjlR
 78RRRYiLLXtorIfqkjunIUpnoRMmjJ82VKGktEUt1SRcMVgEDSJgrpWdgmoUvu1F47/Ihnukv
 8bhxH3brT7VvIbRWV3eS539nvjCBfHrpLaykcO5bnGdC25LNpN6iVA2Wto3PvYy4poAmw6/Cr
 m5lJdvfT1QhVkwP4iM4MxxIDngYnjlOWFhUrOa1fAbwhpPmmDvM95s/IvtuTHIRG23h6jg/bj
 EQNZxoNxsZ3/IKU/+bnANBKv2cpEgHSWzeKM901hrd+ScrzWyV/k8UKzIaChnBVosg0V+DGrY
 hHH1JvO/mqTkkYSnvMA5jr9+eVo/83hv190B/gY5w2bNhvHcBjABxl8IKHbW5s4yEafUrC4AB
 DZ4DR2504OoP7pX70CK9lI4UHIB6Qu/UZNpmCLI+KBxZQHOmalk+SyfR6VSjWynyFGzU38X95
 sIUIhVGCT3B3/RbU/dmFR8zOjCm6sh/Ntjr+qNSVWgzAHfZI9wxdJilCZnvEgzfl0PKo3/nxu
 HtnLKZFOCBo6/J76hwZc91IDsYe5pVvdDTp4FmypMAz85G7fPxHOeFWacgSUPM/wqwHYOBj/T
 oz/n5gmK3H7QKi7VOhDT8l3BNkxRejpuG0fMu8cVVCm9z2R47WgWbJaL4ZWBbHL+iBpYULybD
 /6+pPUwyqDREApfjL7lQ5vGgFuwXIMx3u0DBiiqxdxZNLs10StA1uEY9BSoNa0lfLf3HqbFe3
 aFzhEerRibEUmWPfKWHien2RV+TcxogKXl9QjAVs46nX7RYAEeA3eTc8xUL0xneB7AX7h5dzZ
 RmM1RaJgM6Wysj5ilbbm1CSzNeLrbQWtJcoTuwznYCJS3f+EOjdetQYkLXP4L7lY1VqB0oJkI
 zG+npcXZB/xNGslqnR6DZbEB9+w8lOulazyCaSvCduRjoT85Ky0Noifv+EgyA4U6JBDlns7Bt
 O135SsbxlawarCo4H8Fy26Sarx6bjFvCj49NXOMMbkC4kPLLwBNGyz+W6dIgPWUl4pHisKMAK
 kOT1Js4+CLeJE6YDR
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> How will corresponding software development resources evolve?
>
> I don't think I understand the question, or, actually, are you asking
> me or the coccinelle developers ?

I hope that more development challenges will be picked up.

The code from a mentioned source file can be reduced to the following
test file.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/ar=
ch/x86/kvm/mmu/paging_tmpl.h?id=3D7111951b8d4973bda27ff663f2cf18b663d15b48=
#n122

// deleted part
static inline int FNAME(is_present_gpte)(unsigned long pte)
{
#if PTTYPE !=3D PTTYPE_EPT
	return pte & PT_PRESENT_MASK;
#else
	return pte & 7;
#endif
}
// deleted part


Application of the software =E2=80=9CCoccinelle 1.0.8-00029-ga549b9f0=E2=
=80=9D (OCaml 4.10.0)

elfring@Sonne:~/Projekte/Coccinelle/Probe> spatch --parse-c paging_tmpl-ex=
cerpt1.h
=E2=80=A6
(ONCE) CPP-MACRO: found known macro =3D FNAME
=E2=80=A6
parse error
 =3D File "paging_tmpl-excerpt1.h", line 2, column 41, charpos =3D 57
  around =3D 'unsigned',
=E2=80=A6
BAD:!!!!! static inline int FNAME(is_present_gpte)(unsigned long pte)
=E2=80=A6
NB total files =3D 1; perfect =3D 0; pbs =3D 1; timeout =3D 0; =3D=3D=3D=
=3D=3D=3D=3D=3D=3D> 0%
nb good =3D 1,  nb passed =3D 1 =3D=3D=3D=3D=3D=3D=3D=3D=3D> 10.00% passed
nb good =3D 1,  nb bad =3D 8 =3D=3D=3D=3D=3D=3D=3D=3D=3D> 20.00% good or p=
assed


How would you like to improve the affected software areas?

Regards,
Markus
