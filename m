Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A926C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EA020753
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WaLlXrog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDJL3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 07:29:11 -0400
Received: from mout.gmx.net ([212.227.15.18]:49621 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgDJL3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 07:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586518145;
        bh=KbQ7MPUE2YWxLVrSNpDqZD3CJFhUoxbEHNi7PhcLaU8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=WaLlXroguEeX5vqEZF4wvHf3JPKiJUpXzCFL4a1WEzQIqEeIePoQWYSWWPo52ws5P
         DyNolIyD1oORSPOlVQ4kUoc3wfNU2jvmTAsTLoD936Sb//B1h68vJirfghCAOLfWkI
         Te9aLwKOtossjv+O2p6I3oNAUo581Knfiwz7efF8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MYeMj-1jjdw33Kwl-00Vcuh; Fri, 10 Apr 2020 13:29:05 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: vt6656: Refactor the vnt_get_phy_field function
Date:   Fri, 10 Apr 2020 13:28:32 +0200
Message-Id: <20200410112834.17490-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b+EMgwckRiVQ1Vd8pSMIrXcnbE3ZWzweCVRszrEMKT7dLf/SSui
 1tOBlRAVsLgxAbVjonJKn2ENZpv5SyJ/uRYMmnKlvynVVoq/8jGabI+CGurs6AN3S+/VWFO
 XbZ620WW0CLPVH2gsrRGtnnPdaYs4cbf7tOCwQVz1sYuTI2luxOJdmZ+AguJiLOjZdWURLb
 5BUG+zAhwOongyV6KYqJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pEhguabj12U=:a+yZvb6Xt/hcyn60TYLhoU
 y+2cU/xqP+mQEMdCd3cSf5PMNKPiCrFSvMkM8b5Y8FMfjgT7czovElEs0ChM7y+qCeOvcEXVL
 svfuIdzGnNQ1/1rdwRalqztcXohPuKBUQnxcwUxstwlim5b0kh4KHYUpIvRAqfOyNzkMcr7Lf
 AIuxePzQSd9XmNXLGX8S3im6R1d+lNX/OBPbIfR2wEmgx/PyKSEsrFQs+FJp29HUiW0+afAmq
 cPjaaCE21G07JoIIDHJBD1ddFgnvZbKZJUrQA47HJlrwT6Z1Lqo8Xd+tUvi5kPcUMnXV6FUio
 dRPAwwLv9jYPAYA43PZzy4ZsDzJ0GuUrxTGGUubUxsPDrs3kNEiCyhzHrB5O3CwMJHGC43RUG
 91gDrxi0dSQka+V8daqnsZgiI89w8gP7jQlSN+WzJ5hIzMBNsvgMY1DJn7ow1LL2iYmCrUW1y
 +XQddpKx91wr3amHY8OsvX13DVLBqQ3Z4acIzms7koU3tCxYWqDb6VYWk6D2xRMf92XU33v8W
 +nFTXsdEgj6Zp8lgWoSDottQaGpXY4H3ekXxYF70R6Zo0wXsUiJe/cfVmZQ2zdpAg/SjpXYM8
 eg/qPzdizHMeev4w7CQs1E/XrxCVp/uU57dKc0DZcXsXYaVYqaKrrcnVfFAZZCwGp1hQTywJ9
 BgR5UpLjcAVcpycNRoB1DxHtDtOzHYBtZo1PTVeGrFxpbxmAvsYBSRdCs6HE0zM5djT2TIw4u
 piSn8r1apQjPGA2WDozjcvlKQgp50bNa++PksiYVDAdl6gQBjWPTa+h+gE+TQYut3rI7e9950
 AjDtWigqt08QvDUtkjwZ8d6wMxWbP3N1TMC0cqqe5AleY92NS+fCijTWC3HXO7R6PKP4iREoy
 Nl788lB4A5Vdwfz7ZN7ZXBAPftQtTKy6zw9LT26p5v5vrRHUSX8+SKi0ja+jWaB0guzsClfuE
 XFynU8E1EDopfUA4iVHCSLoWAXfVErGRQEvf4Jxu4fxy8MG4IcA6TNP8TRhJVN/2fLj1269OW
 WkF6z3rcXHxOUmKGpmXYWGBTnXKwPP4FKSfA9nF5goD9CRP3+gk46Ib5mkDs0c4TSBFQfgyLp
 3+FJqaNBF/COVfxLwcP42TmMLAZK8KfX8i6johsl0qp6HZ0CZ5C8Y7qZzD5IxswuhYw0JwgbE
 s5PFnqxb+hgkjxL3rNlWafMWz1N4Fs/kiplKrtwfL20ahzrfT6s+KmGBID5cd+IP3F80YGhFo
 uNk7Pc9ZK29VRtCwh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series makes a refactor of the vnt_get_phy_field function
through two patches.

The first one refactors the assignment of the "phy->signal" variable
using a constant array with the correct values for every rate.

The second patch removes duplicate code for the assignment of the
"phy->service" variable by putting it outside the if-else statement due
to it's the same for the two branches.

Oscar Carter (2):
  staging: vt6656: Refactor the assignment of the phy->signal variable
  staging: vt6656: Remove duplicate code for the phy->service assignment

 drivers/staging/vt6656/baseband.c | 104 +++++++-----------------------
 1 file changed, 22 insertions(+), 82 deletions(-)

=2D-
2.20.1

