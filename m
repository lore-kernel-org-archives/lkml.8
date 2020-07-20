Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DA2C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 803AF2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="uEJTanHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388857AbgGTQoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:44:23 -0400
Received: from st43p00im-zteg10072001.me.com ([17.58.63.167]:55507 "EHLO
        st43p00im-zteg10072001.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732980AbgGTQoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1595263456;
        bh=xR7P0gEG725hD6X8ay110kl9ByPS6ftR/EYV5L9od8s=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=uEJTanHQJRaWghYO0wpxyO3RdswKQU09CItMZePgF2M+4P/vke338Ckc/37kHx6R4
         aYdXRuRiLxV8v0ZFvRiYdraJn6Xv2sYhif49caXDtwBLO48KERv1mJm5jHZbeD3JAD
         cPYZXOw2VouFMxzEp/4Z6a/W4iv4KMkfI0AVpFGtthMpyVGxsA5HqVFKNU1LHfXs6k
         zZ5YtMCV1Do1jMjrVXIl5riKh8JhAj8b2rZk9hT9UaaFNTNX2yG6LJLoBg/wqfBcgB
         ADsPc+jmS4Se1vuc5ngH8pmanVhkjY3YBZXa7ivv8LFEt+nYs2HJhWLJGi+5CEMf4y
         w/emW6PgUkSig==
Received: from juergens-mbp.lan (84-114-122-94.cable.dynamic.surfer.at [84.114.122.94])
        by st43p00im-zteg10072001.me.com (Postfix) with ESMTPSA id 2E776C08B7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 16:44:16 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: High load from process irq/65-i2c-INT3 - kernel module tps6598x
From:   =?utf-8?Q?J=C3=BCrgen_Stauber?= <j.stauber@icloud.com>
Date:   Mon, 20 Jul 2020 18:31:04 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <376EFB02-6CA2-4D5A-883B-7843B6F6B6EC@icloud.com>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-20_09:2020-07-20,2020-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=988 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2004280000 definitions=main-2007200112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I was made aware in the following launchpad bug report, that I should =
report the issue directly with the upstream maintainers: =
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1883511

As mentioned in the report, I experience high cpu load due to an =
interrupted irq/65-i2c-INT3 process. A short fix is to unload the kernel =
module tps6598x.

Please be lenient with me, since I=E2=80=99ve got no glue whether I=E2=80=99=
m doing this correctly.

In case you need more details/logs/information, please let me know.

Kind regards
Juergen=
