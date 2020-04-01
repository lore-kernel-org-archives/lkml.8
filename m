Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7B5C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3112078C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iOUgWYuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732828AbgDAPcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:32:14 -0400
Received: from mout.gmx.net ([212.227.17.22]:56105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732799AbgDAPcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585755124;
        bh=/dW7R5/Qb5AEDqizI8Yf/pT8P60Ty7i0Nhyu77O5eUA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=iOUgWYuL0wo1euHHQ+Xfhija6WsqZNQtIZPOxdt/msHrQ/ObDcd7A9PTIEs7C4Ytj
         pt2cJFBrfL5gQq6ivNcdSWCIMO8o12v2h+yTrUeYmNfl+S0ADsnStYs/QRaUsUGMbz
         nbld7NsqBgF+wT254fyhHbre5hv6RhT9lsja+wUY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N95iR-1jEs3o3zXT-016C1x; Wed, 01
 Apr 2020 17:32:04 +0200
Date:   Wed, 1 Apr 2020 17:31:47 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] staging: vt6656: Use BIT() macro in vnt_mac_reg_bits_*
 functions
Message-ID: <20200401153146.GA3109@ubuntu>
References: <20200320181326.12156-1-oscar.carter@gmx.com>
 <20200323073214.GJ4650@kadam>
 <20200326171043.GB3629@ubuntu>
 <20200331104130.GC2066@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331104130.GC2066@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:2rP4ynpvAFbcqu0r+As38eHxSyzuEzadh73yrM2SaR8Dv55tzV7
 CkEMHdiBOqbzhy4nct5zQO1M1wsBTYsd4TCMjdH9iu4R42NIBvPhSszj4PWH7tmvjqArvM4
 pZLcHR1ui6ARs9a7aw2oh9GrRsvT3/586gdG/DEEtvvhjAzPzY6UGslD7Eunrfqwxx1q6lK
 QGvi1v7lrL6wIRYdDrlSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r41UaLderfs=:CJvqgoQn0JJ4cZcoqmf+vR
 g48c5XWaS4GzuqSXs/uLvb6nEDssNNMLqcm7WpFrIp9AjLJ/VyQ5pZn/BZHjTMN/BsF/KvSlE
 0YDgv+ETfVM0D3dlV0tea0g0+5msYhty+fpjUMT4IVMDUVj45iz5txrG1uPRzg3Jvr87mNIxy
 x3oVkKITsvuYNzaH9yYTW7k/FvyWCPQz3fDiBAupoIxAKzo4zDsVKDYC5jwypa91UtOOlkzS1
 VwR6bmB7Gx7tW2HsbPpQcguxJxsmc+keAAb46FvEBSv64jKfdFBN8tiXQO43VLQyrZfQnjGK2
 J89Mw4IKaNOgaayr1QUk/KvJ+eWAq2I/1wpPCVIRi2xHXAYjS894PqglThnuf9AmxIkBn9KY4
 oEPfZlOU+dZCWhgVbez0ZFbY0bUuBvz+GV0Fpl+sTPM4VS9opbGx/TZoG0FtcA5oh9T1cctYu
 vVLldmZxHzK7lXwGQtGer5QqdY0aVEmvJA0ZgyMXzX291ZApTqDhEWbidO1rrHGhpDplwPAEi
 7+luORbBYQpYuN+++AcMbZ6IvmQ4E2i2yQjkJQa1v0gI8NkJocePAST5GwVeEda0x9+n4wZsR
 QYybvV02VlFIGaYcjbVc78oVs0fPMkODD6xZ4jcpEhyjb+XqNqVcSypeM92PLr0tiyp+osy/R
 GCgYyn/+9VfCBivC9gsVjxazpwnDwjejXUxMtPaPEeJiZW4qKao8CivkZPnMuQm36mH2JN85v
 c7tTtPnxFdFxMhquE9vpeFmRCQbqs8363H8G6rhw0CUGZ+OJqpah6mPZfooCH2z6P/S/HfYhS
 ZbgYiA3yrb2usA3f2AohvO0Qto81DvwhZCksox6e9qN60jd8CftLkEmXRnAARSeb2oy8UMsgH
 i0QTfAqQ7RV4ZF77SUmKgErBB71mQ9iPg2d9zOUuRSPugXTB2F+knyOGMvp5HB55dKpZLfpeN
 zRsOg4ouNAPwnDPE+G/wd9mh9vYq0HwEfDJHi1q3/yGd6423snBuq+uuqCSwoClEb76NtbM2m
 Neouly8fQ4z3cYHt4Fmp9eMACcdhcQfFNy0MJA+pJNPWU7p2MSmfskvy0keUqkSbD+PE1arnr
 IKl666GTWiWFyIp43snEC+9bv+O245g54MbxsU1spoSHYsOinAuO3XkIfN/vBIMcIgycZxtfL
 mev0B6uRafMv28yeXY9+LJI0oPW3pv6M96tOQrhngFeFsV4oFWaFvjGpsdR9gJWtn+JsD9FLu
 TU2knxE8HwqLUdgU4
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 01:41:30PM +0300, Dan Carpenter wrote:
> On Thu, Mar 26, 2020 at 06:10:43PM +0100, Oscar Carter wrote:
> > I will make these changes and i will send and incremental patch with t=
he
> > "Fixes:" tag due to the this patch has already been added to the stagi=
ng-next
> > branch of the greg staging tree.
>
> Fixes is only for bug fixes, not style issues.
>
Ok, thanks for the explanation.

> regards,
> dan carpenter
>
regards,
oscar carter
