Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C69CC433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 20:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D1A22074B
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 20:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="BRNqQB+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgIEUp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 16:45:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:40847 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728771AbgIEUoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 16:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599338612;
        bh=bor4CEdYF1V2mtU3/M6bTkzsiyDSM5d0H+HasDvMa98=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=BRNqQB+U7XaqYbK8YClKi8BjTqQGx3k7rJuKGfQaFkhlkMDGHNXrvfsvQbShjGvMJ
         ICWjHJ8QM6VaqvymrFcEMsCpwCjd8no1EUN3eT8Jv/bpTGM0LkdVev90DJeeEiVgCd
         57qmvz0UzIYYSj7VWVENGW5S7I1eKx9zQT47pThs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMXUD-1jxH8d0oMh-00JeMR; Sat, 05
 Sep 2020 22:43:32 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-mtd@lists.infradead.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Richard Weinberger <richard@nod.at>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Jaskaran Singh <jaskaransingh7654321@gmail.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] ubifs: Fixes around ubifs-authentication.rst
Date:   Sat,  5 Sep 2020 22:43:24 +0200
Message-Id: <20200905204326.1378339-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6Mu0SdARJcxwbmery0IeDoo6tYPNLibtRBfZ3PBuSS279pqe03n
 t99PeIZEDrGDlKLxiRYfUcaGosOTs+g6UYhcG9lIHc7Kd4qdtdlbtCA8wKRfV7/lllCegE1
 G4dhk0svxySQcGcUfwTCt3MaXjaAqZQgmzjk8A7MDeCzCQpsM6SxToPoXXmrVqBZtUij4i2
 VxGp6soRb/MdvhAVw96cQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yjg9DmiD66A=:gcQuXrtC0vq3wkc0nOHdKT
 gJ0+Up+6T5F8z0crIxm886kZ6Iu9EMzzw+8fbW7N7h9EJpwtwFXCq3x9kBHc5xy6cxTHwVPic
 ziFOwJMEDrLMaTtTEvWFs5NNdZ4JpdGMnvkaKMBJ9YgPEfDWqfuamZpJo2gd5hI+ArnWKyBId
 DUYtJxiG0BmVCyQqBFBmubSx+mTlq/rHUESyTjdoUBLoqI2/RxKlSVOJ/HAApjJoVa6qGqhNc
 NLPeXW9qlWm2LWiUjKcw8xvMcFdbwdgmrcs5GCUnyRZWWcexn8+82N/N2yOnUIgt0INQptYgO
 pw7IUAt26O0+IhPERQOqxvuqF+MJiS+ArKoGJqMsQFCVvTGKg7/sRJDBk4SvSfGK0bqJCvlLi
 qHMl6+rjaOB1MXPlTOlDOeS0qBXxXZw6dF4akMJ7D8dKm/W/YDq6j1peV7F6WsmF/O4CwQ5kQ
 Bk62QJttFQbtUJUNxnY4vnbODKhqFAE22M1v4mGWhMPdVT/Mg2vXWBH6I5G4mXcP1GJrrWI/C
 DB6jFlpgcz/Iv/RcKe7FO8UAJANQybvd8ZA6PoVsh7D8BVNotbXPWqtTjT3xmF2+3ACz2AZeA
 O/GTQjSSDvI2xEZG+3tAdv5S5I/bTQJyqlvY/BNHS6ndwdsbdqjQORdgPAVuNitvaqLb2IAry
 GrMSjQfeBh7JumZrWZlfw6PwPsLFOzcp67yBeko2aVMp6Q90vYHX5XftAu4H/8ehKLdOwM6Yd
 bdfVDqIRd11O28v3S7MBfQ2j4gTFWeUAsCk1arvIrnHzrkeBlZID7C1CqTnHdbKqrvUp7Oh11
 OmoNUyugGsvHzXaUt2biXdB6Gq59FgfxEmBVInJFXYJbfk7GYaq0EZmEXRbUXK+sztWtbqT4a
 rDZ5lNS9BglVFYNed7iXrz9lMWdtmp5WP6+OSo2R5K9uSeIDikMk89iLVbtloaj28NRUbOhaF
 PDnTm8L6TD9hmrKytfAz0wV9tlIRZznxWRMF1EseCn9I8ysVlYQyR8swz5bNPucOVWxTZpaOu
 tkWE377lFwk8CL5WcFFrVbc0hBEm6jMbFPBISLQ3LPCiD6UgfqudigcxClyNRdp9/T5I8SLWN
 U1Od/fXIkV51aN8fpisJaGQW8pqsbajp0vjxJE6eKSGeGEXOTqoPz4tEgyiERwhyzcVd5V9hT
 HFjRQilG54of6VRKQJ1LXWHhGy8/n7pjn+sHxEIKjkND601JZGQGUjwOGycQ2pHoRtcsSf40f
 9cMdxyOo20BgUCz1ectxTlGBpS9rScfsMryW6Tg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In these two patches, I add ubifs-authentication.rst to MAINTAINERS and
add a heading to prevent the chapter headings from being listed in
filesystems/index.html.

v2:
- Rebased on 5.9-rc3
- Removed patches that have become obsolete

v1:
- https://lore.kernel.org/lkml/20200214170833.25803-1-j.neuschaefer@gmx.ne=
t/

Jonathan Neusch=C3=A4fer (2):
  MAINTAINERS: Add ubifs-authentication.rst to UBIFS
  docs: ubifs-authentication: Add a top-level heading

 Documentation/filesystems/ubifs-authentication.rst | 6 ++++--
 MAINTAINERS                                        | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

=2D-
2.28.0

