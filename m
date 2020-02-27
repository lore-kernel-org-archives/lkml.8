Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B779C3F2C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E74B2469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="FQ+Ch8yW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbgB0WQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:16:19 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:33557 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgB0WQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:16:18 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48T6Sw6TCWz9sNg;
        Fri, 28 Feb 2020 09:16:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1582841777;
        bh=C0sQUbJcUy3SCxluJOVutQ4Q/pprgmEge+rCNcrvXlw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FQ+Ch8yWcGWV3+pKERY7iAIiROMwV+lINicwcODo5g+5qp73grrdmzJPe3+NXh+7r
         0gB1l5PijcsfeopK9gvtr2ju3aY1x16Am0t12VIEg6gG57lUa+SykMgWF0xPI66mnj
         5WGmRjOlGY54euU0vvGvYGv3wRAoTWTzr4ChBPu1L5+ywoT10GVX+IVvPYOjCvPMva
         ujZLPsqpDJjD7TkwVSos3+XQieM/mtqnINm/fwqhpXhYfUwueYx3li1IgOlkdhM8SS
         szoooUY/aS5MaO1U9a4+lHcDzxPuWrzSjKuH6uTvC2pEOmTlh/klsqVlelMi/1F7ta
         dJLGiMUJQiI+w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, mikey@neuling.org,
        Russell Currey <ruscur@russell.cc>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 13/13] powerpc/ptrace: move ptrace_triggered() into hw_breakpoint.c
In-Reply-To: <4e528bf2-2b53-ae93-cdcc-0c80953f40f2@c-s.fr>
References: <cover.1582803998.git.christophe.leroy@c-s.fr> <d45c91cf5f83424b8f3989b7ead28c50d8d765a9.1582803998.git.christophe.leroy@c-s.fr> <4e528bf2-2b53-ae93-cdcc-0c80953f40f2@c-s.fr>
Date:   Fri, 28 Feb 2020 09:16:16 +1100
Message-ID: <87pndz1xsf.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Russel,
>
> Le 27/02/2020 =C3=A0 12:49, Christophe Leroy a =C3=A9crit=C2=A0:
>> ptrace_triggered() is declared in asm/hw_breakpoint.h and
>> only needed when CONFIG_HW_BREAKPOINT is set, so move it
>> into hw_breakpoint.c
>
> My series v4 is definitely buggy (I included ptrace_decl.h instead=20
> instead of ptrace-decl.h), how can Snowpatch say build succeeded=20
> (https://patchwork.ozlabs.org/patch/1245807/) ?

Which links to:
  https://openpower.xyz/job/snowpatch/job/snowpatch-linux-sparse/15895//art=
ifact/linux/report.txt

The actual build log of which is:
  https://openpower.xyz/job/snowpatch/job/snowpatch-linux-sparse/15895/arti=
fact/linux/build_new.log

Which contains:
  scripts/Makefile.build:267: recipe for target 'arch/powerpc/kernel/ptrace=
/ptrace-altivec.o' failed
  make[3]: *** [arch/powerpc/kernel/ptrace/ptrace-altivec.o] Error 1
  make[3]: *** Waiting for unfinished jobs....
  scripts/Makefile.build:505: recipe for target 'arch/powerpc/kernel/ptrace=
' failed
  make[2]: *** [arch/powerpc/kernel/ptrace] Error 2
  make[2]: *** Waiting for unfinished jobs....
  scripts/Makefile.build:505: recipe for target 'arch/powerpc/kernel' failed
  make[1]: *** [arch/powerpc/kernel] Error 2
  make[1]: *** Waiting for unfinished jobs....
  Makefile:1681: recipe for target 'arch/powerpc' failed
  make: *** [arch/powerpc] Error 2
  make: *** Waiting for unfinished jobs....

Same for ppc64le:
  https://openpower.xyz/job/snowpatch/job/snowpatch-linux-sparse/15896/arti=
fact/linux/build_new.log


So it seems like snowpatch always reports the build as succeeded even
when it fails.

cheers
