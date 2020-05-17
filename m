Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0F1C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 07:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A168207D8
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 07:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="k9OGzAAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgEQHQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 03:16:20 -0400
Received: from pv50p00im-ztbu10021601.me.com ([17.58.6.57]:48101 "EHLO
        pv50p00im-ztbu10021601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727002AbgEQHQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 03:16:20 -0400
X-Greylist: delayed 334 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 May 2020 03:16:20 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1589699446;
        bh=on02TmoKtdgOncp6E9k3HdtNsGqN133gVxjq69i9C/Y=;
        h=Content-Type:From:Subject:Date:Message-Id:To;
        b=k9OGzAAZ736R1MxXDttqxbvadG1pNiei3p2efEoj5uivuczBCpHeNg7pe30bsAZ9C
         xzYXBu1te2TlD+UB85lxvR/igExrFdYvMZMLeLNZu8lH5k2GcRWcN+y5RaKg2goDM9
         GzA0I9lAzcv+NblJq2mkrSnqT7GQuh2ELEYvI8kpVGxXNQoj76Q2wGsBcnZ0ushNkb
         cbhHXP+U4/PnpWbiaNtBNCCNe2WIWgCo+s2fTyC8rM8Lv4yh82T//uZL7dLzEq97/2
         TVcl6pKUtZFqrodi0R2fQbrGZ+Fr5DLr9CremeJBkFqzDO3NfievKOrpibiXIm/FQh
         jFEu40+tUDeTA==
Received: from [192.168.0.103] (unknown [113.173.234.229])
        by pv50p00im-ztbu10021601.me.com (Postfix) with ESMTPSA id A85686E04A8;
        Sun, 17 May 2020 07:10:45 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Trinh tanLoc <trnhtanloc@icloud.com>
Mime-Version: 1.0 (1.0)
Subject: Re: Linux Kernel Code of Conduct Committee: August 2019 to November 2019 report
Date:   Sun, 17 May 2020 14:10:40 +0700
Message-Id: <4BC53B2F-A22C-4736-B5F6-B1C8C6E4B236@icloud.com>
Cc:     linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org
To:     gregkh@linuxfoundation.org
X-Mailer: iPad Mail (16G183)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-17_01:2020-05-15,2020-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=733 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2002250000 definitions=main-2005170064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=C4=90=C6=B0=E1=BB=A3c g=E1=BB=ADi t=E1=BB=AB iPad c=E1=BB=A7a t=C3=B4i=
