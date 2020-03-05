Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8C3C3F2CE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 02:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984BE2084E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 02:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgCECny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 21:43:54 -0500
Received: from mo-csw1514.securemx.jp ([210.130.202.153]:44684 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgCECny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 21:43:54 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 0252hTjX009961; Thu, 5 Mar 2020 11:43:29 +0900
X-Iguazu-Qid: 34tKs0J2puIvSotesa
X-Iguazu-QSIG: v=2; s=0; t=1583376209; q=34tKs0J2puIvSotesa; m=WEUehwg0bIG5XzdGHyhc5DZIIbQUf1gIWxeFjC256IM=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1511) id 0252hRod004744;
        Thu, 5 Mar 2020 11:43:28 +0900
Received: from enc01.localdomain ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 0252hR6N025706;
        Thu, 5 Mar 2020 11:43:27 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.localdomain  with ESMTP id 0252hQtl020217;
        Thu, 5 Mar 2020 11:43:26 +0900
Subject: Re: [PATCH v2 1/2] mtd: spinand: toshiba: Rename function name to
 change suffix and prefix (8Gbit)
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1582603241.git.ytc-mb-yfuruyama7@kioxia.com>
 <41b30e2d308ec7f252d71970a2ed1c29cd25c0d7.1582603241.git.ytc-mb-yfuruyama7@kioxia.com>
 <d2837c89-c9b2-fd18-d090-567f2a90cf75@kontron.de>
 <20200302101254.31ca0c83@xps13>
From:   Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
X-TSB-HOP: ON
Message-ID: <f6501db6-8dcd-ec13-de6a-b782656de0e7@kioxia.com>
Date:   Thu, 5 Mar 2020 11:43:23 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200302101254.31ca0c83@xps13>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/03/02 18:12, Miquel Raynal wrote:
> Hello,
>
> Schrempf Frieder <frieder.schrempf@kontron.de> wrote on Mon, 2 Mar 2020
> 08:02:25 +0000:
>
>> On 28.02.20 04:11, Yoshio Furuyama wrote:
>>> The suffix was changed to classify from "g" to "j" between 1st generation
>>> device and 2nd generation device that's new Serial NAND of Kioxia brand.
>> I had to read this sentence multiple times to understand it. Maybe
>> something like this would be better:
>>
>>     The suffix was changed from "g" to "j" to classify between 1st
>>     generation and 2nd generation serial NAND devices (which now belong to
>>     the Kioxia brand).
Thanks comment,     I will send revise rev.
>>> As reference that's
>>> 1st generation device of 1Gbit product is "tc58cvg0s3hraig"
>>> 2nd generation device of 1Gbit product is "tc58cvg0s3hraij".
>>>
>>> The 8Gbit product "TH58CxG3S0HRAIJ" is new line up of Kioxia's serial nand
>>> and changed the prefix from tc58 to th58.
>>> Thus it was changed argument to the function from "tc58cxgxsx" to
>>> "tx58cxgxsxraix".
>> Same here. It is very hard to read. I would write something like this:
>>
>>     The 8Gbit type "TH58CxG3S0HRAIJ" is new to Kioxia's serial NAND lineup
>>     and the prefix was changed from "TC58" to "TH85".
>>
>>     Thus the functions were renamed from tc58cxgxsx_*() to
>>     tx58cxgxsxraix_*().

I will change prefix from "TH85" to "TH58" .  Since this is typo.

    The 8Gbit type "TH58CxG3S0HRAIJ" is new to Kioxia's serial NAND lineup
    and the prefix was changed from "TC58" to "TH58".

    Thus the functions were renamed from tc58cxgxsx_*() to
    tx58cxgxsxraix_*().

Thanks,

>> With an easier to understand commit message:
>>
>> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Agreed, the commit log proposal from Frieder looks better.
>
> The rest of the patch is fine by me though.
>
> Thanks,
> Miquèl
>
>
