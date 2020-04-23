Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F44FC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CCF72071E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgDWP24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:28:56 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:43171 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbgDWP24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:28:56 -0400
Received: from [192.168.178.29] ([46.223.232.170]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MmUYD-1ijCLP2xNp-00iVJm for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020
 17:28:54 +0200
From:   Erik Rull <webmaster@rdsoftware.de>
Subject: Huge difference in reserved memory - how to find?
To:     linux-kernel@vger.kernel.org
Message-ID: <f7aa4e34-3472-cbaa-8ca9-978472a80935@rdsoftware.de>
Date:   Thu, 23 Apr 2020 17:28:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:rzGcRtocErqHMEBlt9++JRuiXFDRZ+aRw7O4NAKnkFmJ3bYKXEB
 cJyFUxlGIXz27u1vDTxHAmrBUA61DvYV978SIG20X8yrHxC6ACHBKA5qOsY9IEwXpCGctwI
 sy+UGMr9TomUQBlv6yG1CjqdHcNUA8pIIrfSzLquJ0arg8RH8gGAYre9eFM93rU0jX9/pte
 euTUjaMTaMWD4GNDKzXgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j52MhtoBE+w=:e6oeCUiluIh1kvketDBBtV
 lHDRyYLZK10b3/y+MUI43tx9FjN2V0PTnqqIJGuycARkDw1AtFZ7HaXTwnDSHKtXcRSTUJbes
 DbS1BvH+/b8fPPV5NhnXArmFTC3uPhTqyR8I2QQAepl3zEUaAN9vN/l+JyxJOj4YMP/pYGSHl
 G7df3XLjc9XzZY0Cm+U2FUyF1nfShuG4bqDupgp7NgRV40/CCM6R31JdaziKEyDiX8HXDTED9
 ksIm64QZvqTCUDbqfQNl5zNPLG6IC08dapdkNXR41qxRTS/EC+oQAxgepBJTycxphUIbDFPvZ
 /PGEizweFzkIARydMo2gBTp+TAOZKz/kroeTauvjgsZvD0apXXExEd8FwX5kNidM3reoZZDbJ
 WdYRoXlfzrTCoFntV55bfu9iFx3XRbwd092c4HOQdNBy0sSO5S1tt/XoeplVsVRcJ+zUXQCC7
 XvhoTGAa4np1wrkbwW5Ay7cx54rDFpycxuTsv4fzu0F6H4F6YJ+aokSZhPg+XVQNlGMI0HpPg
 3I/uHId4EQtG6ReYXpriZ3oarzfHsH9tt7cPEWfk+GDu9IAuPI2iz2esKULzz4EE1BtyAbD5H
 eM+AmD8MtNT8Ic/uxMIIn9FQMnGaD1E5ezX+ZmLI7SsHvQUyHYs9LvUwuLtoGSygh7+UaM+8e
 5un7krCAGcQy91kAGasylWmob/WxhGBBQyAg/t/fKlocElmtB0yZsUZVU1ydT9Jd0sS8NU1Ev
 81ldDK02wxlehA851Nbi0hcgvq1dhMnqBVfrWNEN6x99uY45MyO6HU4nOhApC8lqchRbu6jR3
 yxuEsR+VJF5XmeEMy97X0f6jGmAFovgCPu5unu6iw/W52waiKG+PDA+IZtco3W4pkfvtf6p
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I'm trying to move from 3.4.67 to 4.19 on a rather old Intel CPU and run into
some memory trouble I do not understand:

The point that confuses me is the difference in the following line:

3.4.67:
[    0.000000] Memory: 235736k/261056k available (4695k kernel code, 24872k
reserved, 2889k data, 564k init, 0k highmem)

4.19.82-rt30:
[    0.534687] Memory: 165244K/260668K available (9050K kernel code, 821K
rwdata, 2500K rodata, 808K init, 440K bss, 95424K reserved, 0K cma-reserved, 0K
highmem)

Why is so much memory reserved in the 4.19? I would like to understand why and
how I could reduce that. I need some more space on the system to let my
application run.

Thanks a lot!

Best regards,

Erik
