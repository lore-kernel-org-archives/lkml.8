Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D5DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 15:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 789DD21744
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 15:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="jN4BnPT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgHGPTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 11:19:20 -0400
Received: from sonic315-54.consmr.mail.gq1.yahoo.com ([98.137.65.30]:40079
        "EHLO sonic315-54.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgHGPTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 11:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1596813559; bh=DDIPGKv8pPTNaBP39e4OFKUALf3JyLizv1xi70HKs2o=; h=Date:From:Subject:To:Cc:References:From:Subject; b=jN4BnPT5nzRv5I6dIPlMciA/96H/Rx8mSsJ+IblK1cP2f0HTa4I3epXRJ7hSydyFoJo6WfwWDPtlG6iUKCVi60tlEy5rzgpLjy2wkkSwkj+VoQFusJIXk1g29xljbMvZXEwWCGXm2B3kIQWeggvSfdMWCg4mkmQAmjj5aC81yihZuViRjT6k4UuNixI9r/NUkHusublyxohVugXwaUlT27Fx4s8tFjC6M2+IR5AiIcx8+igJ5g0a+5z4OPc+yn4Tiemh6i/nl7sFNf9G/tnkbYCSAHfKp+uQFjfkGBhRCVYJnok/mHDxaqC4fQdXD956G705LaDm/x/sJiWS/TRiLw==
X-YMail-OSG: aoq6VQ0VM1l9UFnQ3a1JmKHuS55NiehuV3UbSYoA6S.si0Fo11owzmUBibL2p04
 B.iNKA1x9T8OxZI5EX5fdTShpSAijHR3B6Glc_dGQE4uYY_ncFgUR9LzfIxKuP6ZJxba0G4kW5Nw
 yAfT.3c9sE.qko2p11IyPauOsjIjO9dXfT3aA.YuBpb7J1nDTw6i8TU4raEFp4BEt2zMPrlViPt.
 EMRmvA_3aN8WvbRB4IaJk6gUkwn550fshiF6wKD8EVt_rKmw85g8caRRvAzO.L4bOU.baV4fvE17
 zN9kUdhFkJhlKR__8xecd6ecTX65gzWunDmsQDfaJ88EPjV9uH.RgXKf2NiTbsQ.d9fcIgNLly6c
 BD2hGU54hxaAwqSXPrhhw4jUQ3NiHQZ_E5DWg.olNqFHoH4oXz5kBxnbVL4KDJ8_25kw_4SKNZDV
 PZwkU2PIoxUX96GAwo_j3zEmU5RDO.GOFlA3tnQY_ivmqamrralZ1BeSN_tYzoUODBZS1CXCqS3z
 dBKmsPLlHCx6k7VaBLfNeUeQ7XnA3j2dNl2fxgshS4QwpQG7jue5ykrVDD5wHMFjDNNj_AnMgGiP
 71yZRX7kPPLRpJEIIXqtYckYtNElFfXEj0EfzJhHGlufXKWH7_DtFLk24pjS2dK_lxIzCRIM_iHt
 pU14_jAF.l46AURL._WZ0tNpsti0emU6zIFUFj4WpwB97WqNdYhnKMHRygOhdcS4ozOIu7vIcLby
 FCy4eRHERriWRbjIOppvlHqAv3RtKA8e_cr1tQKpL1.Rc7eeqlGi1vdE5OJuMAzFBxV9vrXRyg0u
 ZxC_uIPOvn1SttwgVko.zznQh3qi7Le096y0nV5z5r6MDxqb7OB5fhcDG6j.tWIqBIXc9OG8J9lU
 iaLIYGaRtqhdqAgRozRzYPs4UnaEiGt22nhrb8qTCmVx2ObJKBKboxKuZY7O29gkAyNg8E0bkOX2
 Y1aLfoAFu8q0QhBsCbS1yLvNXIgPNtfudIMY.vBl4iXSVikvsAF0NKp49LAB5HWojtTZ.C_bSNaI
 8sU4hDy8YM_Gb4T8S4OzqpqCv4pBtuoUFl4uoYeszoJCJUcSWclPFbySCr.hEC05E5xTdzrM7p3M
 dcy9ZoXRLCwAhMM4fQ3q2tM9tPY6G16plLnViKcHLwbDuGmYEi.Hd.rbO1LZAD8RGTRCuMcSG4gl
 DZcEz4Um8A3Y2e6Jx8w.vQTSbeF83qjerEkfVY4R2Z3E6Pdn3i0I1N1ztesCXYSbWsoGHBHxfPUa
 7hBR8jZqOEDX5LfK7CG6F5y6083S__V2jVZFLtBt7fszdKromqzI8.1Re6rYZMqvSbFSxPQjuGrZ
 z_EnsnDeGOAPtdJx.Ihd_7Xwsg5gSdjTxaz2m..42d9ZeIXBp35QoZ9.Fmznd7M3LjXRcboO3paH
 WAEQlIesIFhP7U89Qt6br17ss5dJIgl4Mo4y27cU9ClyiqKMhZ6T4LWs-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Fri, 7 Aug 2020 15:19:19 +0000
Received: by smtp415.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 046d4181f1aaf2890af699b2d693421a;
          Fri, 07 Aug 2020 15:19:12 +0000 (UTC)
Date:   Fri, 07 Aug 2020 11:19:09 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: wine fails to start with seccomp updates for v5.9-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Chris Palmer <palmer@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        Matt Denton <mpdenton@google.com>,
        Robert Sesek <rsesek@google.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
        Will Deacon <will@kernel.org>, Will Drewry <wad@chromium.org>,
        Yonghong Song <yhs@fb.com>
MIME-Version: 1.0
Message-Id: <1596812929.lz7fuo8r2w.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
References: <1596812929.lz7fuo8r2w.none.ref@localhost>
X-Mailer: WebService/1.1.16436 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Linus' master, wine fails to start with the following error:

wine client error:0: write: Bad file descriptor

This issue is not present on 5.8. It appears to be caused by failure to=20
write to a pipe FD received via SCM_RIGHTS. Therefore, I tried reverting=20
9ecc6ea491f0, which resolved the issue.

Thanks,
Alex.
