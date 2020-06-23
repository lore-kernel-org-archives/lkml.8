Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50520C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 233C5206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="coNsu2+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732533AbgFWQ0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:26:41 -0400
Received: from mout.web.de ([212.227.15.3]:57709 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732212AbgFWQ0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592929577;
        bh=8fznmhtFuPVpCCq/4XrpX1hUGJCXy8JOqzHx4+jgntA=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=coNsu2+sPODALoDV1Kdo6qSHnneLeSWuL8C7sCfJMdAYZmSdpvFxgof4g7p7cR8nB
         ebCfyJwg//w8nT9jEG5XlsKLnHSmxXNT91L7uS0StcvNNNTFeRIEu1JUY/1XXqEu0P
         rSOWTyoBuLP9YeMnYAmTZmjAn2Pa9arqjGwfWozI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.105.198]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MUWCB-1jN8DD3Z7z-00RKML; Tue, 23
 Jun 2020 18:26:16 +0200
To:     Chen Tao <chentao107@huawei.com>, linux-afs@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] afs: Fix the memory leak in afs_mkdir
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <91acdece-92a1-c23b-f835-34c8e8f3aad0@web.de>
Date:   Tue, 23 Jun 2020 18:26:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KHUxjgRoNZ1mmP2nP+8HUb/B0jxrrDHaiHhf/9zoXnt87v1zwCc
 zlWgaV+WqDn6KFfcouHXT+kayRj98rFEltGjR73iOkTJdpqyDoCb2zJcxG1mBXz2P62AZBx
 ohSyTjON08zkuZZ6FhF/IPpyDknabtXqY/MZlok5gosx4+ckfEliRHfyV2NTKJpYUyl0AA9
 M/C2QJeVB8gO7i3JxwIbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iCYW0Ze/ZdE=:/pQWITtyOIFcWWkhciwoy9
 De7c89cdZKgSpTm8t0vF5SwC1HBEIqFTrR+gAIr6imOWc2WPvb44JaJ305hrZWwRbfPBHZJmC
 ILOrUvfxzFQCGaOzI3TIq5NfuPXSuXkdPmlWLF8rB1i0VsTylhjjxh+ttDGTit8Z/mkUaaw5I
 qL9D+axpmr9wqdzMCpV9+t2gjRmrRPSmwUmaJjKTPNbX3nb51OaHvox50iTs1XBwa/58NhBsn
 NFmtIWM0vD7X6CemY7f9zSkX8JwiEYw/rLE5c/m1dZPW4l+cW6uneuAm17b5nlTO9M9fDGU4v
 oNMxZnJ5n4rEtlU7O03hisvVJExEx8LQlJlFmaAx882BFBqUoFOGKAwA9XJLZO01SnbvJrRhf
 K2weEgX0/SJjDUVqpubkBqz7h8IvOgppsMNaMkY4cXyZG86v7eZNRAWar9Mb8hn0fku5IkWnF
 lWmGM2IIYoumf3Pdo44IV5XuUUgpQ/7kNfvIWinjh4FlTwB6/g5TIl7ErP6C1K6MZJJiwSVKf
 sq9etraYDoJzjyDk5C++vKro6qMoc83s6mnuMvoLCJtcBS/z8x9yoOtTpEzUuOSEdwxEXJOF5
 3blLMRzCwsm0Yel/2H2vI6P/1v30MN868biBep2RLEVME4i4kCy7qqGbOu8UxagVbSGZzi1Cq
 4IY9Hl/ZSqKbjApLJAFAJts7D9PdEo2gjj+pOpobVV/QKqOBgeyMH5/Bt59rTioOGfdbSfx3S
 ZMFmjWnDABvciQUMfIZZTql/d32cr3hcpJGCgf7xD91llv2JrCwgAIGWZtmOpJaLg4ACELaQX
 RCvOGehrkGT0zNEt8fBH2eGy9wnBGchq9m7E7E40URTn1MchUbHVtGRYSrjEZCD/safOvbkyL
 tnBqJb+Rzod1+43xpvTmHbW6L2qCzbM4KX16QfWL3AnFJfQLCazflFFLR5wM52bjpEBs1kFLX
 YUpyo+vyALPcDw9+ZQKtQzvuy5dXG00dzJnb7rEfTB+rf8qJdXSQ1B4nLzU8rLbuY6a/uZlHm
 lCqiSBK8CZqAPUXx33sDaXkFauz3OMH5ACAwAw4PcZtyYK+hzb2t/AOzCzlueTQWYn9c4zBEk
 lTzB8X2ZNxzdSugvW5Z+lAPSlCieWEoBNYw4PtbEjQzXUHnrcgqm2NmjS8vE+d0utfhRDrius
 BEHCvF0sGIM1u6SsAlhbFbSeY1Yoa9gWD2/cDk+WZuEf120WJQJ+evVhfCa7r/UWYzk+am7BE
 RCVe7DxNNF+hIPwKF
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +++ b/fs/afs/dir.c
> @@ -1599,17 +1599,17 @@ static int afs_create(struct inode *dir, struct =
dentry *dentry, umode_t mode,
=E2=80=A6
>  	scb =3D kcalloc(2, sizeof(struct afs_status_cb), GFP_KERNEL);
>  	if (!scb)
>  		goto error_scb;

I suggest to adjust also this jump target so that a call of the function =
=E2=80=9Ckfree=E2=80=9D
with a null pointer can be avoided.


=E2=80=A6
> @@ -1645,10 +1645,10 @@  static int afs_create(struct inode *dir, struct=
 dentry *dentry, umode_t mode,
=E2=80=A6
>  error_key:
>  	key_put(key);
> +error_scb:
> +	kfree(scb);
>  error:
>  	d_drop(dentry);
=E2=80=A6

Can an other label than =E2=80=9Cerror=E2=80=9D be nicer here?

Regards,
Markus
