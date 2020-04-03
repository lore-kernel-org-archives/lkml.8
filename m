Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EE1C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E6B206E9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="JiJCxQcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgDCTpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:45:46 -0400
Received: from mout.web.de ([212.227.15.4]:53685 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727809AbgDCTpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 15:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585943122;
        bh=2wiZ4lVoxw2YhxjCeGelueT0FHG1EuPNuwT+OrG1VuE=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=JiJCxQcxSpvQPGJ/h/EQaU4UwjwLaPM85xAdBNtRRhHr3AUHgoReSMf52haeEYczA
         EBePvQS49lhYV30kk7wgtirI8vK+anFp7EF5TDy1dqwHRhzTmRu1c2G5xnpgBwwwWx
         0Ioq2fB7eOeppw6AFgEiEsfW6GNSx0Y0QCrTmwbY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.25.116]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MMWA2-1jPOjU06fO-008FXz; Fri, 03
 Apr 2020 21:45:22 +0200
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mailbox: armada-37xx-rwtm: Remove duplicate error
 messages in armada_37xx_mbox_probe()
To:     Tang Bin <tangbin@cmss.chinamobile.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <2f136a63-72d5-43ef-2a73-67d6984b848d@web.de>
Date:   Fri, 3 Apr 2020 21:45:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:M8gCHDrL+Xfttf6SVR6+2/6PcwK8pdosInIdsoG8PzBegbhr6pd
 FipkvbRprHcA2UwzvB+d3SUbH+lHzH9Z3kb0AAWf8GFffUu2xAPlN/fWfF6+zaos3nU6JHO
 FBXIB7bI5qf4Bjuz7HBEUHQAEarNVd3/V1vqgyvhntcEmt3qsbtXuYV67N0Z784ovsX5Qk1
 6rloNWdL/lIismXcQh7Lg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bYPNv362bp8=:SfSkLnZTpuehoi0syk8PGx
 1Z+fMMk5FtWC53pq1QC+UobgCJbAO7SSu2z3a/SOYeTOP60scDomIRPIJ4q6WqNXT2nTwg9xZ
 iZE5lnBvbGGKb0EOfEGO/uKgxwx8U2hHHbjlx6obsSQ8lMY0ZbzkLl5sw9j6QNJL25gMcoDHi
 oa2x3XpPBJTlekT4BSj9412JzzYUbv7NLEc5zRIUUTaE2VxuVTqFQxGJ0Pn+oUNvZnB/m5QsU
 EVHZw8o9RGO7ux3jdA+tDPsWso781GBz+av/B8XLAy+kZBz1EHk4BxxgQVYmDw4YFWUeRg52z
 pq748ViH1LtHP+Jy4Zip36Pz7WRq06LRsOjf/4LABkrfhf4zI53ZdIWbwHr/xZ2ArOkKrhZB3
 wMXwmV3qDoni+VLxcGuIIuzPaweAKV+lzL6oXK6r5N5Bh99PTQ1S9KJUa7XLng4INfcWYJ7u/
 AFlED+mTspiV0yvGSu3OAOXvXbkJWAjzdKlIKyEYygeGju8kNpOvQ+MAc8s/DiWoQvQtjYfIa
 o7/dJFS+dslNLegbzPllClTUQBCJ4Hx/EpPuZl0cGGWEgxwBSYETifkXYIBT5U+D+WzFX3Wr3
 1XfwxiHDkBVEmGUKe+4BeOSlaMMEbl/mm0mIbqNK8gluX+J7peZNlEH25NFbc48SsSx/6kVQF
 2CdGRm+nBWJPu+/mil2nFj5UQtA8B7PMZOigKvRpYn+Tpr7/KW7RUrvZwioeZp5cLKK15tfI/
 Pdm/Xflqudyx/ye0HxbQ7Qztgk/cGMU2ZtLjd9jQe/dg48ylBBuYJ9/LMq9mWtfxqxHIr6WvZ
 8RYUtSfxXK494m5js2D9OfFowBSidBpCl2hNh3YOyoVLJHDY/D4shNmF+f0DSFvoZq/vOH609
 tF7ff+cPQQYr3ILnlULvZr+WcKfAA3VTqpnS6156uEC/Zwqymx5q96vO60Itx4kPNoaro2QZ9
 ajz2C9DkIcOezQYxzifr7+GeAq/35pZnPfvECVLU2xONuKEZKkJwxBgoP6PMKRqKiWj7Og2xp
 pKTEguUbaGQlKpKQW0E0PhT33x5WqiwFD3DEH+CYYZtNT0KV7ecm01NFIB5ESvxwQi7WLYYbZ
 rYoARYb5DiHV30THSsIPdyR2KjJnsVOT92YmAIhYyEW1Z1V4uiYxD962WvUF4QccMQYCRdkVA
 KWhY83AlY+n26n86eBD+PScATX/fQBDJqpjDnjgPSARreQ0dnN1PceFTMCw4yiaRkJHVASU9u
 vY6b3b56NveKeMTdk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In this function,we don't need dev_err() message because when something
> goes wrong,platform_get_irq() and devm_platform_ioremap_resource() have
> print an error message itself, so we should remove duplicate dev_err().

I suggest further fine-tuning also for this commit message.

Regards,
Markus
