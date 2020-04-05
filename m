Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A10C2BA15
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026E820675
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="MEoDcvQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgDERTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 13:19:48 -0400
Received: from mout.web.de ([212.227.17.12]:42195 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbgDERTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 13:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586107175;
        bh=I1mJGt7tqZdsCK7Z/QAnN6a7dQhCfJ2cUtUPPTk6VFk=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=MEoDcvQNZ8Tyj3edJr9fXmoVS/kU2oIralvVuoOCJbE3K+l+iJvAAS1KP3nZdXyAU
         jziOywFhqfxf1UxexlTfKV7uv/2j1uMF8zYPsIuon7oAMqi3pfHem9SPuz80TAENeS
         m9nNkKf3zlj4iQCsTtHOGcOLdI9UtocSECYij7co=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.99.70]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M4qOX-1j7Jwg2s0L-00z1hx; Sun, 05
 Apr 2020 19:19:35 +0200
To:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] virtio-mmio: Delete an error message in vm_find_vqs()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <9e27bc4a-cfa1-7818-dc25-8ad308816b30@web.de>
Date:   Sun, 5 Apr 2020 19:19:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/DGBrfjxUKMqQQRcsq/TOjGSOdf77WQbv+I0rGwC2OMIkB3+ODg
 rdSvEx0ElTgpXpjwuuuJXx1bYOcSrsQqeAUQspAKMh2YgjcrWItrENgz69/VcaM53P4c4kE
 oqrILcAvcXHMj8+Ci9E3ainJR+5JDNcvDSeMyDMKkH6S4X6P7u76KqV87cpvnhOf5UbyD2y
 FXSmDtS3tTjZXgpetcehg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m3cp4YkNUQM=:Uhh69XQhDSROm6KaHDeuwF
 8TAdzgf1frcBirzHsYelP0ozD3nkUGrbKSZkIV69Pn3kU3aMbtG8VwGLgz9/F/7ILNwSqVuBK
 yJahGOgQb5JmmjwnR3hXl5BYsKvrYUkgM4gnhdqKwWsn3+oJJx2VP6K/nDLHJeE7G3UqDvZHV
 jp1qKe09imneuT8p9pP74NDqa+ltVyo7KvF5oUhSHUFS0y5S+rlfKIeDHEUuDLyHX2r/BrJ0b
 psTjBmtlYS03ZnKGWX+vY3QJx46BFgvM8nmQJk7T6O3UR8pijIQifV+hIp1t/KwE69kxJjz1O
 BRvoS9g+ramXSD4YAnPkeYmIK5wJU6ZSqYalRZ48ffco5oaIpVJWOzcfP+iNLspYSXP8D3DjV
 xEmvDUSmTfOB6xWhJcUf/vPLXvDkFJz0Ava/UF8DBorl4yAdSRT+ZrYIBmOIMZViYKIS0Df/G
 03okHi7gauOwR+xyWpz6i08+zWZIUO9XXraNtdZuLjsq3DXfFxvqrxLQG2pRU/DCeEmXEI+oV
 bEtXwr39vwC8W9dmArnLTFB+3A3QjhY2yUHn/sMr84TIxoVt0PZB2jBrBX8sx2ILd4HW61B+E
 FiyRUlemW0cCc16xhYCGbfNTeaUCq6hympRyuxbvZhEFzPWdG3rLK26sBjeqCIRreN7BHkK5/
 scnNb1m6bx1Aop+mCH82JIH4YxY/z8GaD5zoq5IN/3SyemIs2iIKa+1InIoC7lpLCoChlA3Dv
 c3MPf/xWCDSuMsqarQOi0UWLD5lpHixlCubtAGP8WMeuAdCvqBjH2quwBA6bcarREgSTcTltK
 QonqWCD6Lybx859nqJyNH5uOlkYgRL52hsTPIMHGYUqC3pzDnwhugWWS4Nk0xKpmy7Jp4xmZF
 dQZFJfqtzBAOfYe5l57JRHzY6pAXAbCQM2XGwL+zGICkXnkHYDFRTD/l9KDReIMx2t9w0Rc+j
 FSUmeX/1WPBxWVkh4Wt/5lliEGF91uP0OXrG84NcehzFHEg7wYUd7nXITb1l+p95QC436s1P/
 Rhb9A4Cc1EpSUmULP9zq2+qlF/JCQyzkQ6O49eTE066zHbNPZ4/qbTUc4LulZUDnjxY4qNLl7
 uDJxiiJjF4mACGQpC/PhdJOV3iBu+ENzoaIbyGSkF6jgpvGCR1Um+9l4XLcKuL5j1jMrE7Zqh
 gYR/ArafmB7gkIb5koZBBGzgyz1I5e+DOe12ZXpmovZbZDvad8UQy01LO1fulayccInmoYFYi
 WlCYjPUyrANmtNTzx
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 5 Apr 2020 19:14:10 +0200

The function =E2=80=9Cplatform_get_irq=E2=80=9D can log an error already.
Thus omit a redundant message for the exception handling in the
calling function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/virtio/virtio_mmio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 97d5725fd9a2..9d16aaffca9d 100644
=2D-- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -466,10 +466,8 @@ static int vm_find_vqs(struct virtio_device *vdev, un=
signed nvqs,
 	int irq =3D platform_get_irq(vm_dev->pdev, 0);
 	int i, err, queue_idx =3D 0;

-	if (irq < 0) {
-		dev_err(&vdev->dev, "Cannot get IRQ resource\n");
+	if (irq < 0)
 		return irq;
-	}

 	err =3D request_irq(irq, vm_interrupt, IRQF_SHARED,
 			dev_name(&vdev->dev), vm_dev);
=2D-
2.26.0

