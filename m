Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D74C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDC720719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rvr1iq2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732906AbgDASXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:23:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20516 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732579AbgDASXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 14:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585765421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qsVnV5ETV+wC1OGQJYaji6oxvDTV+wJkvOYtON1RAdk=;
        b=Rvr1iq2AMROJui7z8PuAkBejyamdf02KFH6iRMg8bmd5j187AcOEgzCrC+gwL647ZwxhAM
        B/Rmk91jzF1ectc8i+98CoKMeEirw7gyYhpe8G9393tmkKJzDTR5FMFs86eohXecjOjUvx
        gH/VSab6CdVNm4PvlTGu6msIEGV1uJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-tMRfsWLDMnyYNimT99ZxWA-1; Wed, 01 Apr 2020 14:23:38 -0400
X-MC-Unique: tMRfsWLDMnyYNimT99ZxWA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 249AD100727C;
        Wed,  1 Apr 2020 18:23:37 +0000 (UTC)
Received: from treble.redhat.com (ovpn-118-135.phx2.redhat.com [10.3.118.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91E9F60BEC;
        Wed,  1 Apr 2020 18:23:36 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 0/5] objtool fixes
Date:   Wed,  1 Apr 2020 13:23:24 -0500
Message-Id: <cover.1585761021.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some objtool fixes related to CONFIG_UBSAN_TRAP, Clang assembler, and
more...

Josh Poimboeuf (5):
  objtool: Fix CONFIG_UBSAN_TRAP unreachable warnings
  objtool: Support Clang non-section symbols in ORC dump
  objtool: Support Clang non-section symbols in ORC generation
  objtool: Fix switch table detection in .text.unlikely
  objtool: Make BP scratch register warning more robust

 tools/objtool/check.c    | 26 ++++++++++++++++--------
 tools/objtool/orc_dump.c | 44 ++++++++++++++++++++++++----------------
 tools/objtool/orc_gen.c  | 33 +++++++++++++++++++++++-------
 3 files changed, 71 insertions(+), 32 deletions(-)

--=20
2.21.1

