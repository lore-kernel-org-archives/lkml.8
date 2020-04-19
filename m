Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F4EC38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 11:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9DA42080C
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 11:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ITj8k+Hi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgDSLTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 07:19:18 -0400
Received: from mout.web.de ([212.227.17.11]:41167 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgDSLTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 07:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587295148;
        bh=+MT/PHhCOU+umyki274Dz9q47Fi4lBnIdM283WXTkXk=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=ITj8k+Hi2sCWJU+d1vzZY1tmGYXNQbLyqE5Kg7o93LdjgwEH7m9liSiYE4SQkwcmB
         LQB9s4iaNlOjEqV0+rzt+Dlk5Sy1vQ9Pd8I2JPqdca6bHjPPzgCqDd1c5DjdNthuwW
         eDy8T9IGiv5+Igm18YiZDO9ZtgdWnHoz16x/zsso=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.85.208]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lqleo-1inCKU0pqk-00eOhI; Sun, 19
 Apr 2020 13:19:08 +0200
To:     Tang Bin <tangbin@cmss.chinamobile.com>,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: asic3: Add error checking return in
 asic3_mfd_probe()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b9626e96-4bdb-e7e1-51e7-a99210de4c32@web.de>
Date:   Sun, 19 Apr 2020 13:19:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:m8+snKl6wUzMdqlskiUQ8P7+7gLQFhOmp4/QZdGWkLvs2oa2AgA
 hHBfrA1ABkfCZPmsn1cqyy0cl6I0G71MrXGQUnUdUZyi0zJEfnC2prD2/IQjqmADkS5C9Ta
 mp5gkzjLgySkCU+gc1BFOFsWi0wgFfX5UtAgcn3NetbJ3JwNJ4zIGvSwIvTbRrq50n7+9Gw
 XwKGbIcnWxtJzx0emydBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GWQvNnP9sU0=:TaDlK05GCLQ/a/ULvmDRbm
 rGnCidHuuwS5IJrUnzrkvPe8Vez0sSRhBy0q8lXVADsHMtLtj7v52T4ObOE41LuWtwMioWjm6
 YvFT8iN0oQrBzhby5uy6tPA9A50BgKoVRAmOnMo1pmDCAaBh9zQlcQj4zlYA1NetXnsUr5yH5
 KEQ44nOr/SW97KFIqwMjNMUJx/OqpWlMwLOGT8BQqlAKxA7jzHgBqAyWaO1x0NvdSpdnWg8QK
 nIwY8Ro3LcRUaNFtuM/LXsLA7ZGkZvQ8WZVnWNta1948xTo6noOI+xRWS9mbBv67KK0ZVZV0c
 Zg1/M7P9L58GKHPMOwmuOOIy/wkO7AOnfsaHc7j5ffa3CuRpem7Haw4MFD68d0yO/aVnG/o6e
 Z/VAvQRXvy1Ocx16bkDukOzrfzlHvO1Qfoa1hJfvrEcO3tmt199TNsd3SayD5ImUzMOGFYkRN
 rJk0N5/vi5v9E/kxdqogKCA1oE4CqJCBIV4H0nyNQjVrtjkWastoPVrYyP31fwxpvSS6446L2
 Eahxus4vnnJzJXzmR4wuDN7Q+ngxgpvJ/hJWyNW6luzz4UgNJAK2Pf7mY/d6WmbnQRuTWBcCC
 Uymj7HLj0pxbMdaOR9eEv4sUpDBylXY0zzTb2oYZtZHxULust/HWM4IiGIsZ0BUelO3LaGAC/
 LHSlggpyF5FWpqLqJZUfVJQJMylJRaFj/G9gw1kSb4KR+pElrkeNGT5SLpcFSzttkfb/v7TDZ
 Mwfdu4B75yhYlKlh6bPYMSSX3mlYyvlzfXVky8oh++paNlORh7xmN+DJcHhNB4cxQXPmUlhTP
 D+ASO77ZBSB2PYL97uXGbhsBNdMyFxuoCDbFpiXr0G9kO+OgfviSjm+2QFXwF2Hst9QRMgi5w
 upOY7OcD4aUBkfmKxed+zVanDT3k80K+an6Z62+kzMLZJEnALmVr/Ssbhpg5oC+WmLINIdA79
 pYlr24dpcAbrejnlrAxDje0CMEHtklyr+VixnBstF5wHXfpWFiKDJqZq1tboK4GJXiJCdVJLl
 x1aux/luHmgcFM2SHL8wfS10jft1K78Utrx/6b/mrozysqQjy9Aqkn/Gk8dp+BflYWo2QkKz9
 FYChOMv/7BOK0nHyEVtrLGn3CUz3I+Vn/C80HzzisPJxVe8skJocY1Y4kQitXKf/MFtY8TCrK
 Q+VH+7+U1XLhGP+13+R8jsgdJ2fZchRQu8GG0odS0RkIg3pNPJX7OtXFA4Yjbeod0ABk9wqlo
 YIc4Iyqbbjo2qwbxs
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In the function asic3_mfd_probe(), when get resource or irq
> failed, the value returned just detected and debug error message,
> but there were no error checking return. So add the right error
> checking return.

I suggest to improve the commit message.
Would you like to adjust the patch subject?


> And remove the redundant 'ret = 0'.

I propose to reconsider this interpretation of the source code here.
How do you think about to move the mentioned statement into an else branch
at the end?

Regards,
Markus
