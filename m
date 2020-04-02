Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441F6C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143EC20757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="URcYYJoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389591AbgDBPyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:54:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49427 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388677AbgDBPyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585842883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hgr1szwPzLJm+lu6P65U6An0uZy5Dnb2dNnfpMioOSk=;
        b=URcYYJoFGkHNvp3xSZNoDsJxdUhvttRFO2/mS+9w55V382Ra5XD3lctF/eHM2vk1Um9+qY
        cWVcVQqfVG4Bss0wE8B5+VJziHAfV8ThBUGGh8pX5kly4nBdFohDwF9V27duQgaxbehSlz
        K0ATr2kSYiyfzfxxnRgmuZNbJUn/ZNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-DNu9NLHiNjmr8LkkHduC1A-1; Thu, 02 Apr 2020 11:54:41 -0400
X-MC-Unique: DNu9NLHiNjmr8LkkHduC1A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B1C6107ACCC;
        Thu,  2 Apr 2020 15:54:40 +0000 (UTC)
Received: from treble (ovpn-118-100.rdu2.redhat.com [10.10.118.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C738F5D9CD;
        Thu,  2 Apr 2020 15:54:38 +0000 (UTC)
Date:   Thu, 2 Apr 2020 10:54:36 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        Julien Thierry <jthierry@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 3/7] objtool: Add support for intra-function calls
Message-ID: <20200402155436.q6qbuezmmarr24qp@treble>
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-4-alexandre.chartre@oracle.com>
 <db508586-258a-0616-d649-e76e95df9611@redhat.com>
 <4e779423-395d-5e2e-b641-5604902bf096@oracle.com>
 <20200402150407.GD20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200402150407.GD20730@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 05:04:07PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 02, 2020 at 03:24:45PM +0200, Alexandre Chartre wrote:
> > On 4/2/20 2:53 PM, Julien Thierry wrote:
> > > On 4/2/20 9:22 AM, Alexandre Chartre wrote:
>=20
> > > > +=C3=82=C2=A0=C3=82=C2=A0=C3=82=C2=A0 sec =3D find_section_by_nam=
e(file->elf,
> > > > +=C3=82=C2=A0=C3=82=C2=A0=C3=82=C2=A0=C3=82=C2=A0=C3=82=C2=A0=C3=82=
=C2=A0=C3=82=C2=A0=C3=82=C2=A0=C3=82=C2=A0=C3=82=C2=A0=C3=82=C2=A0=C3=82=C2=
=A0=C3=82=C2=A0=C3=82=C2=A0=C3=82=C2=A0=C3=82=C2=A0=C3=82=C2=A0=C3=82=C2=A0=
 ".rela.discard.intra_function_call");
> > >=20
> > > I'm wondering, do we really need to annotate the intra_function_cal=
l
> > > and group the in a section?
> > >=20
> > > Would it be a problem to consider all (static) call instructions wi=
th
> > > a destination that is not the start offset of a symbol to be an
> > > intra-function call (and set insn->intra_function_call and
> > > insn->jump_dest accordingly)?
> >=20
> > Correct, we could automatically detect intra-function calls instead o=
f
> > having to annotate them. However, I choose to annotate them because I=
 don't
> > think that's not an expected construct in a "normal" code flow (at le=
ast
> > on x86). So objtool would still issue a warning on intra-function cal=
ls
> > by default, and you can annotate them to indicate if they are expecte=
d.
>=20
> I wondered the same thing when reading the patch. I'm confliected on
> this. On the one hand auto-detecting this seems like an excellent idea.
>=20
> If/when the compiler generates them, they had better be okay too.
>=20
> Josh?

In general I prefer to keep it simple, and keep the annotations to a
minimum.  And I don't think this warning has ever found anything useful.
So I'd be inclined to say just allow them and automatically detect them.

However the fact that arm64 asm actually uses them worries me a bit.

So for me it kind of hinges on whether arm64 has a legitimate use case
for them, or if the warning actually points to smelly code.

--=20
Josh

