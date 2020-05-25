Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1259FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEBCA2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="AvdK9ybJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389660AbgEYJub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 05:50:31 -0400
Received: from mout.web.de ([212.227.15.4]:50595 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389356AbgEYJua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 05:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590400221;
        bh=P6sswJVCyID2kisGSDD8jTyeLQrShJTFR1PjTv+eZxc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AvdK9ybJ1tADJV9pR1p0lQ0HZxOPqaf/sPyVksHLjIUi6nvluP5yqliA5p4cIu5ca
         Uhzsvdzmi3gklEef4ML9ixSFY36l1xQ7CWy/Nr9LbBDMXYJga9t6GT4CNR3CX3cCfL
         POdgqS0lIj7sPqzqCgYM8YPSsJTJhhchuXIYXMZM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.186.124]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJnrh-1jJA1M0SSH-00K70i; Mon, 25
 May 2020 11:50:21 +0200
Subject: Re: [PATCH v2] workqueue: Fix double kfree for rescuer
To:     Zhang Qiang <qiang.zhang@windriver.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200525075901.12699-1-qiang.zhang@windriver.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7d19381c-2c51-deb4-f82f-d54bc56c6ecf@web.de>
Date:   Mon, 25 May 2020 11:50:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200525075901.12699-1-qiang.zhang@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/CuB+C/LELFimNzsT2Wxe2zFsNLbNR1jiONlIHhnZsAdjmp1iQT
 4a3Z8zTk6peY7avnTRfu6iWy4kbgAX0pKulHM1+lPvmRoQ1/1kFqiGnqVPXKR7HfxX159Nj
 aW6dvFj9avM+8KDTBIupWH1D3Ehx8TBF6hHKu24Kp9O7zUiJUIU0bAfe860Hq2L0WrkLJs9
 ysHYMIbM2OXA5O0N0e1YA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t//vjUJuSxg=:fYWUeVqWWHsoL4CYrNEAG5
 ZyGwLpyhe8VTj4MHd0nqek+8Jp9RyabwjK0IzpUf9dRnIOX81m0FzMm/8AHYSdw5exgy1Nkav
 Jer3v3P6Y1hw2xdznmcec1gtRHf7oJxzFJ+3dmDvJCHwoIpqK4qsu7yxiEUbQnrk+4ZRDJZXX
 +38utp+TVTRrdRlsyZLMPVnjZARLL11mc/935nCwyCd04WgoeYRTXsYNhJX8Ag+XrjV4sclhD
 WqYZLPmeHW2GKVaMvxj5PX7L+wjctEW6vPy4GODuGgE/5JJzwt+36zVHUB+l38G9Viv/V+mxG
 cgfC/iknm2IRWHaGTf1g+4j4KOab8h8dTWjhjT66U2TsdBOD6Z+e3gy2pzTSNb+wDeD5o3HeQ
 XMsnBPwGjy0Tc7CO0Ef3GDajYmRk2sSSX4JgFOFc9w3g99iYPWQo7phCWH4gcAgukjROZKd8G
 2gJX6EXIcO+TYo2Aqb+4WtWIx+x/jgCEq3sfgVXZMeZN/wNFmwyMmXtYP0IKdnXU7Hbhg0Lrr
 Gc0UJbYQIMXbtRabqMbDjor/s4umXtKrClPP9HUL0ftWVYjh+HvtlrSenIKJtr1V1eCs7Aco5
 fmnwa/2PueOp+/OXWz+Y1cBgRF5JRGe1ZRqGQtrz49YrQqYqkbKCKpcnIHHvsRz2rHPdpo/Lq
 5bDk+p9BORZE2c+4TUANTmFvzKEwXEK0F310noMq5nT8kNprcnnh7+mIVuTxlYNZYhOhMUt5H
 ejCSauQcdh1nq0It7So2lRnLadvJliq491LyGckjmjWrBDfCtSxOfmIGEokPfviKxF9ltPP0w
 cSZJfjWG21D+tnzkD8F0wAqRzCJxhiK8dFD9ndphYXqPvhxz+ZTk+zf58mFe9r5rKeVdf7XP+
 ferkBHOgyMCeUkBuzTrqGQAaDG5UjRFjc06U47T1eE5oL53j6ebrV3bxcwgFZcDkYGuj16gbN
 Q4RQu/CtepaYbXBr4WiPfS0nkRPQ7vHUJ5AKCRPm4Vd/NfQ8/ofiDK/I0Aw1G3wddlQccKu4w
 0UpjXoM986J6Z4rsib07z6UiiDJ2FqO9wWf4QEENZyMkGq+g1nqPT+/QqsttThulIfJs0RFia
 ktxze+mZmn2uY3Pu68/URGMbLhXp3fEw1dAjPsbW3q4Vql63s4fzC39Se03WWJtuXzQijx6Ln
 CSp4qY4o5Uy9W6KIvyk2z33VeqSg/xnnL05X3hxJ36Rj0gp9m+LfywNU9X20Fsmg9+LcsUWJK
 i3+kRULGc5HuaMDLQ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The duplicate memory release should be deleted from the implementation
> of the callback function "rcu_free_wq".

I tried to help with the selection of a better commit message.
I have taken another look also at the implementation of the function =E2=
=80=9Cdestroy_workqueue=E2=80=9D.

* The function call =E2=80=9Cdestroy_workqueue=E2=80=9D can be performed t=
here in an if branch
  after the statement =E2=80=9Cwq->rescuer =3D NULL=E2=80=9D was executed.

* This data processing is independent from a possible call of the
  function =E2=80=9Ccall_rcu(&wq->rcu, rcu_free_wq)=E2=80=9D in another if=
 branch.
  Thus it seems that a null pointer is intentionally passed by a data stru=
cture
  member to this callback function on demand.
  The corresponding call of the function =E2=80=9Ckfree=E2=80=9D can toler=
ate this special case.


Now I find that the proposed change can be inappropriate.

Regards,
Markus
