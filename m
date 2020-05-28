Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57525C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2857B207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="NIVjeoGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406834AbgE1Tt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:49:29 -0400
Received: from mout.web.de ([212.227.15.4]:48433 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406793AbgE1TtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590695339;
        bh=+B7LBaGX99S3uPjCcCLsxs3BCct//Xlvs6N9ytdHIBk=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=NIVjeoGVrMq0EaifFBo73HopbicIFYFK692s4AY2G+YxiNBiGaAER4Y16xPF2eIxe
         iDrA5V5kwYEpwmG3UPxERXfnb9vd8FbpkyUHh1JHlWijuJlT0pUEhXgbjaCkbmBcuV
         qO7CFafeAk1SDOS6G+pExj10OrPTWS0GAJiixa5k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.30.242]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWBA1-1jTlQ207p3-00XL9c; Thu, 28
 May 2020 21:48:59 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Vyacheslav Dubeyko <Vyacheslav.Dubeyko@hgst.com>
Subject: Re: [PATCH] nilfs2: Fix reference count leak in
 nilfs_sysfs_create_snapshot_group()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Qiushi Wu <wu000273@umn.edu>, linux-nilfs@vger.kernel.org
Message-ID: <30cf7534-b62e-84b1-571a-945aaffac5b0@web.de>
Date:   Thu, 28 May 2020 21:48:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ajXO0YaxVu1A9JNlZ6X1YWeTq2R1Ffmuf9mMz97iM2/JRvJ/LV7
 iQ3dfXP2v5wBFDQx/M7/lEuxLCow0kymXxATnQI8laJmtop5UhQRsYUp0GwL4vd7LuYwCAd
 UVsBlymNld+f+VXIaDxa+9DZ4BOdCBcLl4Twyqn+MZ0js6rO5QnKw95+doivJymrU/aBgCG
 ab3c/asbrD25nFdUajCaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EcToFCvm6YU=:EaU6WsQaqAnoenU0XO/5qh
 44qS66SJR4YAgNw0JjQPbXDD5ypMBEtuxZwtxR100l7rnjC72UhCUYpOPssT0MAzyEu48qolE
 lI5thNg6W+YZAcFOVJIqDeNrh8DaYSvWp8LzyZ7NiWULitGFg2NAzwg9t4ch6F7Z9fLe0B1Wp
 tHddzksJj+47wpPfRSPBy7ZuyKOResZ2feCA+StpsReyVgfE9j+TO53/lq1uLnvkSO/4eNsDO
 b48CK9cjw6EVF+ReO6bVCr4VFIWlpTmwcfvb9/eYbJZo8vNgSMySTYfS9XxWLcULaKgCazP65
 buL35NxNvOJORDVpIwTrXikyIooPf01oXhvdobc3SCtLx6kBJPPCdYcqTmLvpQ6SxgZ1Yar9m
 dB+2/APD3841wV6SzEeTaqH0Y2GjUgq6qnde+p+Wp8KISDZ3SET7KM+I3ZlKpzHi9KhomKXhr
 iUBM9Ey0Z0sGcvawqQB914rbVxXG0fHz0pRj2bUdBMeps2FQmLTPLVDzjdWhD5o5uEW5Pa2cf
 cnDNG02xjC2+zMB3mHlTdy9nYMSH7O1VvpvHIYxRs13FKIf/oNF1gjGPa/rPdxIiZxD+H8Zvw
 Ulqyp5l01DdO6qNHtk/yMBGLO5gYlKRXyjqSmgA+xRmN2Agw31B6zX7umzYC9OFGQxDQhjp2J
 P3H4xrI6HM3UQgghuH01nLVmCVJn4TJ5sFqrrD2e0ufILAyqiVxQPScQ14kfvCaC9uvy1u+Ld
 NL20LXljSYJ3yZfdldGxqqzgAttylANp8rbz0me40BfCbAkicQPRxwdxdPZd/oZ+1u4eNWzoB
 +A146TKtiM8Ot7XJbWEr+SDhL5o75TIggfGpYAGMHqkyaOEbpU9oyD3jlFqYXLKwfmejphjGq
 eRCmXZ6uycjfvhS+ESwj9jlwNJioR2NIJ4aVnTDXRitTcZdMAO8RQY1S3L+qAqbEkSHhqY3W+
 SjPN62Us01Cp7/YuCuDZtNUspfgXuWYp8nMWSvgEkeE3Jt4uzsC24/eg13PKbTyWf1yHeTv4y
 ZQjsM4iIdRZxCLNLkhOHKb7Lj4dtixGYfZ1Boc/51Js6QIRFRC5pvC+KL8IwUrn5wsmBtCrpw
 bDz0jnaUUlhm6soVwiaHyhk6EDk4TYd+2UD62CYpGWCdubHOqiPV3oM8I04HRY3kcIQ37DmlV
 jJs/1cJqG98/1lQ7PhlUR2YKE+tvG0DHdyEdCi96BS3VjC6ly+AngTATUKIXqRwKoeR+rx7Eq
 9fTsX9OmM28fq1YKw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> kobject_init_and_add() takes reference even when it fails.

It will be helpful to mention which object is referenced here, won't it?


> If this function returns an error, kobject_put() must be called to
> properly clean up the memory associated with the object.

I guess that an imperative wording is preferred also for this change descr=
iption.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3Db0c3ba31be3e45a130e13b278c=
f3b90f69bda6f6#n151

How do you think about to combine this update step together with
=E2=80=9Cnilfs2: Fix reference count leak in nilfs_sysfs_create_device_gro=
up=E2=80=9D
into a small patch series?
https://lore.kernel.org/patchwork/patch/1248696/
https://lore.kernel.org/lkml/20200527200933.31135-1-wu000273@umn.edu/

Regards,
Markus
