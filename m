Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D44C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 01:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23ED8207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 01:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="FPqjK4QC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgHUBJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 21:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgHUBJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 21:09:17 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FAEC061387
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 18:09:17 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6F267891B0;
        Fri, 21 Aug 2020 13:09:05 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1597972145;
        bh=ea61aITYXCZhhViYI/miCG03GiKcr8uYJNlbvLWSTo8=;
        h=From:To:Cc:Subject:Date;
        b=FPqjK4QCA44XQpH+5bCsog9UcVGDYvr1C37CCFyP6ZsMLtnjbD3/RDt+ySuMlEDg8
         kzTxwI8GZqgBjUjYAMBiVJ37SqXPGjC2TfI11ZVQpXFbH+ndNowJiHEDlRJUrySFH5
         ZOU7DB2P60eir4hWSvo5lRjodnrhArImWYj0mOgY9VAH9N+YDlr3BWhl3mFuUP1T1k
         cGSDsfOUj/ZCMnJiEWlF+VxvVQ4jw/u77o8JYbPe9A0xvgsMvElfS3dMxvDWFshAEP
         iaiWtu+1pO8Vc+YbQLTxmiDAhAW0p89XJPxNKyrq+hUPWCFhYXr8NQ/EhUX/L99zIJ
         xL6Rm9O6X2CsA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f3f1eb10000>; Fri, 21 Aug 2020 13:09:05 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 1EBD413ED33;
        Fri, 21 Aug 2020 13:09:04 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 39A4F283B16; Fri, 21 Aug 2020 13:09:05 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/2] docs: Remove stray ()
Date:   Fri, 21 Aug 2020 13:08:58 +1200
Message-Id: <20200821010900.6362-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed the stray () while reading over deprecated.rst. I found the RCU=
 one
when grepping around.

Chris Packham (2):
  docs: deprecated.rst: Remove stray ()
  docs: RCU: Remove stray ()

 Documentation/RCU/lockdep.rst                           | 2 +-
 Documentation/process/deprecated.rst                    | 2 +-
 Documentation/translations/it_IT/process/deprecated.rst | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--=20
2.28.0

