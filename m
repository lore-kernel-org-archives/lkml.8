Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B70FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F388A207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="e2WZBM1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgHSTTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:19:17 -0400
Received: from mout.gmx.net ([212.227.17.21]:38245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgHSTTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597864750;
        bh=yGhmMdv+lIK7WWvL56fGXEL2pIOM9t2H0GSnoqzCBeQ=;
        h=X-UI-Sender-Class:From:Subject:To:Date;
        b=e2WZBM1vPnSvo/co8JO3+wSjdLtCRb2wgXhC6IM9NhpwHBD07B10PzWJZrYzCxWCF
         RGI9I8SZeBo2Ann5JmKdeKIp0eq/BzabT0kVwBcJCU6jVhzPR3gx1goSiL1eI0vdJO
         G5T8/TkBulG9hx5xWFCDHgBsEFRIAAviu6d/7gow=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from obelix.fritz.box ([46.142.26.43]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIMbU-1ju88Q1gdY-00EQt5 for
 <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 21:19:10 +0200
From:   Ronald Warsow <rwarsow@gmx.de>
Subject: BUG with 5.8.x and make xconfig
To:     linux-kernel@vger.kernel.org
Message-ID: <ab0cfaed-50bb-5b29-cb93-a2987c384af1@gmx.de>
Date:   Wed, 19 Aug 2020 21:19:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MVabCcPeWKLikcSzoluI1k4Lg8Z8AVPkQ2fgypOrqJv+hz8RIHv
 qfbUUv4gZ7QfMiMEAs0ZQmsH3g5yoM/+f1x6a9tykKHISRGC6234adctK+S+EIN1u6Ck1Ek
 eJM/nRXNEjhUnFOCkabhjN0+YI9FWZlWznZyY7sCwu/ChAB1FvEPW+aZmU+a7nfBmBMCr3p
 2lJvtLPCL0gaV+wg7xsiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H0mbDdz01kY=:xpEE4DljdEGxw7hcPklrn2
 GUODoxVIPBPixz3OOVo0cWbQ7oUYbxQDICQ+ji+VlfxTwOFJMSZUcSGrjdoNAQIj/p5VulNUv
 kLVo2RRrueq+DnFnkpVcARvhGXhkNmiZrmQwchoibm/T2w/WDq9/fbSlg5FCWarJHX7OQQqBR
 KZPITWa6DOGFN2/sJt7xN+HFHuoi6sLwdXmhLO2HbuGUZEaODLx5ATluvCBUhcd1+pot9Vv9u
 bMfVITVkZZhh9DflSwqXAit/OP1J0oklR6RYkTM74iiUUyu8W4o5cfnbW39/wObMwrv6P4+5L
 /kFgJzZELgFy8dEh98n31qQEfRcR2blzMormu7Lu6iopEnEa8MksYf61KP+8VXfV/f6TSo1IY
 waOgdun0zhN6AuXDMAWWJ8OvkqaUX1SABgAa+Iq5AOFHkU/iZf2264lcnecGfPk6eeTpGlFj7
 BgIWXA6X2jA8LNkn97UqSP5YtNsrg8mUYaarC2qIOddxmoK11RYy1XdCv6tcw+J9KgnDXudZm
 pWzAkdY+jcWxjtMZzLiFW3D2HzIFLpID8g92FbNwjxLQuEooBTmN/jMHMEM9SebUVWuxcZysg
 yK/LQLpToAQy5GM8GmlQE6jW47lAguDM2kOm7xU7uamuyuiNvbOFRhECmaCjzZNM1tN+Aoq7T
 dLDZRMGlUCPgQJCTaCHQv+XIdNWvdMggr8W9qxX31FYUmdM3DDlLDOiU19azE0ggmilFnbVyC
 sgTWmlaEHvlwF6dRaAHbmOlc5CwjdcAjC8qtkYE7SUNwcGnA4RRwLFzE8cdbCtoeHM4P7X5pD
 ynXuyd2nbz/LNoKoyJ4MRRyYqqvs49mo1Y6lOZ38tt1JW/DUOK6jbosNHwdOnIDR391yajgNG
 OCMwkcI8D8x8ELJEB5JqG9mkloy9SKMiR6NEWcsl1lanM05rB048eaE0RWe/ran1OUw1dhtw6
 juhLlVF2aOu9CD9b1BFmuu+feI6YiGnBhY3sPYeLLNi5p8fqvdY0dZID9542xNfIMW//KoE3y
 2eae5cTcfh5Y5CcYTknTASFx2/UanQERJI+JppHcPdag5eyn27YSgiRdmGEEvUN2zeIho6lcG
 YBkDNePD6F9YzvHbmpqsJNbtc5vglmYpHGHRxT18AnghEIFLvvY5mWNTeNRSBw20sIFEXrrsd
 Jm7QyIgTf+kGBS4GU9iuQiOpmsi5udkMYJ1cb+lamaVC3X8iiukj5rnNK1WCGR49VKfq9sQGH
 8rdWzaTMx/LFMKP6a
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo

configuring kernel 5.8.x on Fedora 32 via "make xconfig" gives me this:


  HOSTCXX scripts/kconfig/qconf.o
scripts/kconfig/qconf.cc: In member function =E2=80=98void
ConfigInfoView::clicked(const QUrl&)=E2=80=99:
scripts/kconfig/qconf.cc:1231:3: error: =E2=80=98qInfo=E2=80=99 was not de=
clared in this
scope; did you mean =E2=80=98setInfo=E2=80=99?
  1231 |   qInfo() << "Clicked link is empty";
       |   ^~~~~
       |   setInfo
scripts/kconfig/qconf.cc:1244:3: error: =E2=80=98qInfo=E2=80=99 was not de=
clared in this
scope; did you mean =E2=80=98setInfo=E2=80=99?
  1244 |   qInfo() << "Clicked symbol is invalid:" << data;
       |   ^~~~~
       |   setInfo
make[1]: *** [scripts/Makefile.host:137: scripts/kconfig/qconf.o] Error 1
make: *** [Makefile:606: xconfig] Error 2



I have never seen this with kernel 5.7.x.

I haven't found a solution to the above, yet.
- apart from the workaround: "make menuconfig", etc.-


pointers/hints/ideas ?


=2D-
regards

Ronald
