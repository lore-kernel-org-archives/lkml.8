Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185F8C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E0D24695
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="sr7kNImy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgB1Lz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:55:58 -0500
Received: from mout.web.de ([212.227.15.14]:56199 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgB1Lz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 06:55:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1582890919;
        bh=S3FRLFwZQiSYQmQLSBvn6YhuQwVmVHUOUm4e3DlWNN0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=sr7kNImybirc9XM4CL0HMQKgvh9DS/7Vb3td+oHdHnOUA81y1nYk7hseq31oWcugd
         k6/jLecLFAdu8/qw+lhzXK3obpSRUCdRLUChsMoo+2GPqfMJK+uXFEa0a9epO0XZcz
         uge4OtkvTEhKHeCEAurbFYdq1ZCA+vPSJsuktysI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.179.252]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LtXDY-1jYtut26Fw-010sOe; Fri, 28
 Feb 2020 12:55:19 +0100
Subject: Re: [v2] Documentation: bootconfig: Update boot configuration
 documentation
To:     Masami Hiramatsu <mhiramat@kernel.org>, linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <158287861133.18632.12035327305997207220.stgit@devnote2>
 <158287862131.18632.11822701514141299400.stgit@devnote2>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c4a0bc10-a38b-6ea9-e125-7a37f667e61a@web.de>
Date:   Fri, 28 Feb 2020 12:55:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158287862131.18632.11822701514141299400.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8bcj8FIIWYnmth/ewzToS9eQe+rOqY3e7XQPfBkEWH4WzKH8x6A
 bq4OCb0Jty52ssGO0SKkDQnJyHKggEkfxB9w8YNYMtRHHDavLq1F4iQK2Wm5JSeZm3GZxia
 rdBszLtgFzBhnE8vIFVUmLUdf1BRqX+d1l4QxUr7VkY9rGxEU+CrtcJ7+Q1i9+rg1dzGaTq
 ZPTrvvtxFVBVS/4Q0xr6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VMqqKu6hcRQ=:jYGdj2Xcu9AIAprHlSba1G
 W6rt/zX3xgukxyrNkHrft5wKFsX3YZAqiM5TSFCn4BLLnRbjYdaY0eHrLPeoe+4SEIbLLesgH
 TzA0pbjc5DsZalg4rDmRS1FzqjPX2pToDFiBcunc1I8cuE+dfdHFGYT2kAl6svQZRkaJk/pP5
 eNBz6anAZ0YNDmzuGcoo/KrRA97t3SdTI+uDhyrx6RMweXsYuJA1qV3bW8mBNnJBmbgNt/7dh
 yfRI5CD8rrk337n3d8PLqCoA30D8oOefEXFDQQAESwAMikuKA4iQZm6JLWWOSgXp7mw6+g95/
 XbfyM8cu4MBGoTalfTyMOqnXZVIno5vy1iwC44bm2y72kxU/CQTW1VDALXWG6+NGNX9DOuIEh
 3JaTIgOyX5Ya/3pnRTJkZmxBr/3RDtZqfNX2Bpn+eXVDsplR2Q+E6pc/1Kx/TZJ7lVHjZHGTn
 maaryzn2MpnT0ycpE4ClAZkqk+qbL1qVAlyWVOK8opDaPx97NRj0TrNXOCRQFypBDO4d0tt1T
 nkxo/eApRLvvm6uO5Dgb+npMCQUdiLHW1FdnCXxFSzSsk2HfTd4vm7sH9H4hzmPb5rWHHT8SR
 0ZOcwuxnWDHuC/JH6XJFpTHykSRnJyZ0QgV/ACS/5FpkRqXY5Hdgl423R6NLGocEqCrMqrxCx
 6gRPnKyL4Ot2A9kyl7wHJ0ZTyowYel3q8nB89Mw7yj//ky1iOrYClNXqi7O7Zgk53+vF4O3WO
 A/NLylDQNoRsM4am1npqBHxjaGDhyu3We6Bi4IPpYRV1ugZgh6NCZTyrL+34WCtuJduEphMlm
 N+POdiXSDStLnOwFWtYph4xAFZsqDCex6rmQ35tl01sSALMnLFIEF1aLgLpVwTuoscoiUKKcP
 CdLGlTT9fG22j7hv7yNV35k2SGzs0e2lIRHXmk3isOpnavgKeyCWpFWUgIsvcorZeaVO78jfA
 IIckgotm6R3eoFQaQB+30SW7AGnb0pEMOHIwjzriWLfimG3r9Dw5jDm58gOhA1FPkEY4UoGgF
 QO99dG61BBUSekZ1UnpTVvLwCv+Iyy7ZZFfDElWQuwVhmA+/Dh/pOLk5FXQsZ0bQUc36Whbwd
 WF9T5FiRO7GQkvDLJlym/jmG/BL+d37XfdfL7hKvcQQQ8NOesThqhAzQb04PjUt3vu84nwnRe
 2QAnLosw2q7yG14V589IzunwL0qJflOAAM/12En6G1MN1omiz4dlgtunyQuMulJLdEXD3ZibJ
 FK5JWVSWYiWEebtDP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  However, a sub-key and a value can not co-exist under a parent key.

How does this description fit to the key context =E2=80=9Ckernel.ftrace=E2=
=80=9D?

Regards,
Markus
