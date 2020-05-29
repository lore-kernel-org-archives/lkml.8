Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B118AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70C7C208A7
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="He3pHNuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgE2EwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 00:52:00 -0400
Received: from mout.web.de ([212.227.15.3]:45591 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgE2EwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 00:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590727910;
        bh=9s8HVWZnrNlsYF4NgOgs7U6BwK85FTelc8UkaeUj92U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=He3pHNuw73/ydGfKjr8y1sAUq7NpqVU80PSxusgCAC5qE9qIGvAjHvmC9Kn7SAOUk
         3yriIoWdsg6CQxyfr61+EKjX1Gh8I5l8ORnk8BYOgUpDiSkOQqGR4ISzGUvpRRnEJU
         0E02a+h0o3/qhJoLo9WIfP5GX7Oj0+DE5PR+GQg8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.188.184]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MEmbK-1jlhzo2cJO-00G5Bd; Fri, 29
 May 2020 06:51:50 +0200
Subject: Re: nilfs2: Fix reference count leak in
 nilfs_sysfs_create_snapshot_group()
To:     Qiushi Wu <wu000273@umn.edu>, linux-nilfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Vyacheslav Dubeyko <Vyacheslav.Dubeyko@hgst.com>
References: <30cf7534-b62e-84b1-571a-945aaffac5b0@web.de>
 <CAMV6ehE3jm4ZasYqd12f=e0TNN_kfiX7yCMVHkmESKP0WbuqTw@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b4e9eb17-7c5a-15ed-5ff7-2334ff13e9d7@web.de>
Date:   Fri, 29 May 2020 06:51:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAMV6ehE3jm4ZasYqd12f=e0TNN_kfiX7yCMVHkmESKP0WbuqTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XKuf8ZSnXQHsZOavZvRwDBXRig77n6U6qj/zp5SsPQt4Fy93B1j
 RZC/dHuQ4DiTgYCoiazeqHYqnHzzDuHKLV7On+uHL3H805+i+gHpiH5QLBZXMxuCUKLw72n
 DTbMLtFME4FE+IvwRzwwfbganNwANeuV1mCW9RQ5S8k8ZJls/MYplzgcvnVytO384aC9CU+
 ExDqaws9NaSyAfVAU2rRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SG6lFVkg1J8=:EMwtzq9KUnlOS0M3glXrmC
 IPxt6VrTRiC5Ubzt+sTr+aSIvq6INFpV1Xn0RYGEc7p71u3pG+UUN7YwlRUtMF/lH8bDnA+HX
 7Mfx0AhKlw6/g/Io7dcR1jS1K2s6xm1a94n7GzV8Fscy6ZChbpDELbjAuDN7PsS1zMz4qCzum
 bWatPwdWiyi+7iHY1lx+mxcv85VDcYjtWdEEnFbcKcu9g1NBL1P52CarC4t8w1inf8yio1VXG
 vsv8Lp5u096sBqukmgu9Rji47BXR/CXxvDnT8A6cEmpSSkOGmKVNMaQUNSDvM2Sfn8k412z8u
 BC1PORaHQ2Vx53SlDTM5uruSQoM8ZRegY/RpsrgFvTog3TXU3G5mHmAfmKJQcJpNv9QveFK5h
 VhbLhgyGbxg3ROrUiT6gCfu1V5flDkiyB+9p+YrLCUuOp10dwOjn6ueYGQ5UdUf7dDJNPUG7G
 zRM7KUkZQ5RbxULiQ93yxOjCMeoArX2jAdUzXc/UdlszRyLnNbNj+kmm5K65+rKWKjsgCCMZZ
 FfQsshoGQ7+ly8JdfbnF6XqqD3RgVZJlsDDbNtSVujbRCw8/CT1+tDvWO1IbV3Vr+QFOSXo6d
 fhcqjPbD6ZHLejg6/xlY8Lon1F6kDUGWb4inlSB2VMSXduDa/6LI9qakQPo7G30gpz4Tk0ZZn
 ScXKGxE2uQKEqZNPZNzaPmsKRy0s7IxGdoaZPufECQBAC+1vx2Vhk3F3Jvx+Q+oAaxvIzsb90
 jMKNrqcdurw139TLwg2RDPWlErC/XLDvid0nqlpwayZxQ1nZY1KCeiL8B8TaRW8X9sgZsJzBP
 dxn7UAcTfNnJL7BWXG8h86ys95w0DZ1/8aRUKn0tamQtOdl4Q0SYqaiq3u9bO+NVRrI8h9Zvz
 8Ad6AGS4Y5kfGpvk7l9PdKCg53+8zMA5xdTTXe1fT5mwspk0VpwoFna1ymqNFdIvaihtEZnpr
 uVjIbx9LFDTKozY8bBqSAmb0NToKTAuh2cbgSwG3n2vTxf1KclI5rWhLF96GnsNfsGLh+IZ48
 xsBCibpa5s/IVxDDfqYMuvjQnG2d5o65srRvYJivFaq7QSjQyVNAqGNzxAVsxi/7DDqQMtxXH
 yekZQ0J9s5Se6gHgBULrcUiPzm8auRMtoeH8M7DnlkO8Pvlbf972UW3sGmkQIsGqquunLqLzx
 5hS3fuLWlViI316F+nj95iys24zXHFcXXwC7JgJnVRsM10c4EN2RLBl5AJbAePxZDy65MtHfX
 BHpYnfF4E4T7unYzD
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I think there is only one object that can be modified in this function,

Such a view can be reasonable.


> so I didn't mention it.

I suggest to reconsider the conclusion.


>> I guess that an imperative wording is preferred also for this change de=
scription.
>
> This sentence is referenced from the code comment, so I haven't change i=
t.
> https://elixir.bootlin.com/linux/v5.7-rc7/source/lib/kobject.c#L459

I find that that there are further possibilities to consider for improveme=
nts
around the presented commit message (even after the mentioned copy
from the function description of this programming interface).


>> How do you think about to combine this update step together with
>> =E2=80=9Cnilfs2: Fix reference count leak in nilfs_sysfs_create_device_=
group=E2=80=9D
>> into a small patch series?
>
> I'd like to improve the similar issues after I reporting this bunch of b=
ugs.

Did you find questionable implementation details with the help of an evolv=
ing
source code analysis tool?

Regards,
Markus
