Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8414FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBC820772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgGBMyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:54:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:39112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728917AbgGBMyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:54:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D508DAD1B;
        Thu,  2 Jul 2020 12:54:47 +0000 (UTC)
Date:   Thu, 2 Jul 2020 07:24:49 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Hyunchul Lee <hyc.lee@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Sandeen <sandeen@sandeen.net>,
        Nicolas Boos <nicolas.boos@wanadoo.fr>
Subject: Re: exfatprogs-1.0.3 version released
Message-ID: <20200702122449.suld7mlidvpfxfoc@fiona>
References: <CGME20200512081526epcas1p364393ddc6bae354db5aaaae9b09ffbff@epcas1p3.samsung.com>
 <000201d62835$7ddafe50$7990faf0$@samsung.com>
 <CA+icZUUjcyrVsDNQ4gHVMYWkLLX9oscme3PmXUnfnc5DojkqVA@mail.gmail.com>
 <CANFS6bbandOzMxFk-VHbHR1FXqbVJSE_Dr3=miQSwwDcJO-v0A@mail.gmail.com>
 <CA+icZUUiOqP5=1i6QtorSbjsyaQRe1thwcp36qfTdDUnKKqmJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUUiOqP5=1i6QtorSbjsyaQRe1thwcp36qfTdDUnKKqmJA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On  9:29 02/07, Sedat Dilek wrote:
> On Thu, Jul 2, 2020 at 6:57 AM Hyunchul Lee <hyc.lee@gmail.com> wrote:
> As said I contacted the Debian maintainer via PM and he is thinking of
> taking the maintenance of exfatprogs.
> But he did not do a last decision.
> 
> You happen to know what other Linux distributions do in this topic?

Suse has incorporated and backported exfat in Leap 15.2 and SLES 15 SP2.


-- 
Goldwyn
