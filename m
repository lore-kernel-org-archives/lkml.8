Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CECC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 06:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F12E520723
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 06:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="gNCGfebt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgFFGAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 02:00:41 -0400
Received: from mout.web.de ([212.227.15.4]:41239 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbgFFGAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 02:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591423234;
        bh=H1Ao6vP9lU9EngLrseK+nBm2ub0kJKTgSlPISojb9Fc=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=gNCGfebth34IK5pFJBE9pLGSTqQJ5oOHDcK6xbnOs54+Glwmobfu+iHqs6TWgy8Mv
         Tg+oyGvX+0UO3oVjx+rxcF/ORcHju56yAliVMj9ro6eGznniks3bdy0LJ3Lw0vWkqG
         faA04T7UYmIF56406SiX1L4SkTX6FNxpT1C0uQ20=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.40.239]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2BI2-1ixzPY0HuQ-013cVF; Sat, 06
 Jun 2020 08:00:34 +0200
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: Re: coccinelle: api: add kzfree script
To:     Julia Lawall <julia.lawall@inria.fr>,
        Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>
From:   Markus Elfring <Markus.Elfring@web.de>
Message-ID: <e10d3917-da30-94d6-9f41-b0343daf3e23@web.de>
Date:   Sat, 6 Jun 2020 08:00:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YRbsCH7PYA848quT921A20ta+BtCVKbtvkjQLNMZwo7UgvP3arS
 oHuP2hBrrwCnlVaRqTvnOTmPuvoFqEh6z1JmUhrU5aAU4cQkiplI9k8d3RTD+SLTQpHTT9b
 ED5mg4NfN4xxinp5O9BUr60e4P31u3MfMsAzjN3KPBriyPpZw/jqSfxzSphk6Ihunh5hvaD
 BsVxfZZUC2NS8qAZt03vg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CMT8fhY/qqs=:oHylNa2ezW901Ss5jsFNbz
 KqHJbN0AAXIwlFx6sc0SnCABecSqlWMrHLxA3JP/bi636I89HYqCOR3kqKdCelcFqMzBuuV/h
 nke0fBo4HGiXYxda7Cy2jA+GrY8pSfE0N08DOTXnl3vyNkxEXmTGMuiVX8wpMXYt9cq/7+DAj
 fmo9aiN7rkuyr4mkKSzwtbn3QZHJAgPMJuvGLytQcRgQeYa1Gu9T/6cXGy7VnKasAwTmCq9rS
 2TPAGXxcuoGtQFEYcv61H8uDlP230YaM7MDCHPifsYV7H7V5GLcD/C2Jmvneb7jMCldzbHGkL
 TjHS3EP/uzW2QKlvzR+2ikG0cxl63Vu+9Ww/rJ0mc1Q/q0mBAc6qDeV3CRxXTvzwotgJGesVW
 D4Na/k9T/8g29QuINlvPpXMMiNon9dXWA/NDLf56zwG3czQnqUSVB9V1VT8Qp51/pBtQbKKDd
 0EfmguGxtJnNSq1Af1pbbTPVD8yOif7Rvpc7ZaUm8L3kC0yLiVLltjXvPOmdIMaHwS2NGp2ez
 pJem+hmpx5AnsHnxV/uruUJzBn0hQ8kLv/41uCR9NLaegwCkuainsBK5yitE+b2UfVLnXz3jn
 TeV8YbQ9qJQnz64vA7649IKpBIlHAhKsPpYtYsUYffWehxrfXSWVmAPf3crjZd2kyyMpBrqv+
 LFAhKNSk5xpC+IsCKQoSKF4Wcjef9NSkk6YZi7bG+DO4626GGmG/phMvupnbJg8/03xIfSbc9
 6Yj4T8mvMihusUYb1oErlts7rb0hAAJ2/jXdRIlKpOcELW89VQyrnKgrbkoHDAV3t97WqrQiu
 cWIhQZuvZzLITXy6pmLoDdT5z8k9197m6SlHUgXZxv7FwSHJzXZlU5uCXf/EUFLre2EvseZUH
 zSRadRWrjrbYThocHY3s7DPzBzCAz81LvV1+prQ1hNa6/tHB+JXYBRa8MrVlWu/ehuyFKnkv4
 0GGlTY1hCC2MCpJRyGXTFR3JXAJi9CLyE0mYt/VDCxquf6zt2dDsDKxtCDB+w4JyamCiImDAj
 3agqsn8w7sCC716IBsOqs+gRl1HDdwoi6Tvc2mrGV0VahFMASaTF34q9s+aX0naFzrN3LB21x
 3gK5rfzyMrRbZbwiD+wTRLisyjuXl0qJcBrsKRbhuV8T1d96hKPwQ+OBHKgytVpgX1JLHDl+I
 IjcI/6i/3AWKATYEZdXTpkckdWdfHo4TP4xCB8Ns0vU/X7tDoHaeMErclVjQIyZSxvK/qgzXl
 yWyVdhlflLBnxwnR3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Is avoiding transforming the case where E is not verified to be a pointer a concern?

I imagine that answers to this question have got consequences also on
the confidence level for such SmPL scripts.
The desire and requirement to specify data type restrictions (for expressions)
can influence data processing efforts in significant ways.

* If it would be accepted to choose a simpler source code search approach,
  there are corresponding risks to consider.

* If you would like to reduce the general possibility for false positives
  according to advanced software analysis, the amount of data processing
  will increase because information from header files will probably be needed.
  The run time characteristics will become more interesting then.
  Additional program execution parameters will be relevant for this use case.

Regards,
Markus
