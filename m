Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFD2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F8C206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Kpx4JB4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgFQSp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:45:57 -0400
Received: from mout.web.de ([212.227.15.14]:33093 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbgFQSp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 14:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592419541;
        bh=4i9bh4fMglL9c1IOl+452IcyPvIm1+ptzTfbM4OAYPs=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=Kpx4JB4ILiABJTLdP45rxAjzHi4QC/0nwJK9jpL57ihSLi8uADCtdb899KA8xHaUx
         AME5UQ3fgE0wavG5pC63PwsBWB1srm3G1ts7ghrLjmpUNtz7GixUO+glPbZw+1uePu
         OxDa85SnWmkmJtb0uoHSGjg+t2GC27LsrSyJFSAs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.115.66]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MBkKF-1jdcSR3ktr-00Alkb; Wed, 17
 Jun 2020 20:45:41 +0200
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Denis Efremov <efremov@linux.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: coccinelle: misc: add array_size_dup script to detect missed
 overflow checks
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Kees Cook <keescook@chromium.org>, cocci@systeme.lip6.fr
Message-ID: <a91200c0-b5ce-5c6c-5bd1-1a03d94d9d6d@web.de>
Date:   Wed, 17 Jun 2020 20:45:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:HcUNXyJuWZVTxBHlxnK+UaPN6tu8/08+d6j91jR82H70L89noCI
 AsfHqEuyQGeE6oEpHwVOyB9oZXzsOh+pb9fEAa4xwGfrr1r1afleNjqzCBXas18T/iQBuiv
 NNM9o2m83AouItkXnmRUgOGMnCXCDTN/1QVIQ3+sQgZhtfjjCHkBjvPTm2f33FX4Wm4fne8
 lDIqttAiFzX+N3bXMMB3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MNa9ecvXeNg=:jG4ccU0SVG6FCU4hEt2FP9
 2fJGExp1/b5gYBIJvxxje8FiqDZfNfq+ZAdiA1XhU+BMWi62CyJ2S8s79fjhSDqm2yMGFlRnR
 QWAmnV1nRkpAiTUk464b0MXVhLmvIxOMBicucgIh1+AuyhScvz8I/bKFswPu6xsXyYov4kHvF
 rvnv0/yAF39FyGMnl8WEOmSV6HdLkml1ikLVkge4iAXbuwIAPuyVLCl5miLDPWlzduydWRJw9
 Z2l/+sPKkfgEW4R/gUDflbvveIcnkJ9/E4MMPY9gnw8Oz7i/u98IkCpXjq7ZdsQqPOjYIEgQz
 DdDsyqtAmZrSVSN7q+65U+6S5FK9nCsEZX1gurTBQpEGx2JVi+wd4g8prCnMtbTrM3xuFzXGc
 PJYNTlpEsP40h+xUsFTdcTu+8sCIL85G/WJ+n29pV6ddklB60rZ3o5mvKOv+sNLQxunjPI+G+
 kqNE41cBMeViASZwjVIQJmnnK73UzMPbZ5FZFYxyCxByhIap9apF3SeG3YdKUDm3a+YbP91eY
 OgW5+QeoxjVEowtnIUsEJ6Q7kXMz8emP2ZDzJDb5oVs+FOP/+qVTUAtfJTrLmy2jvp8mtVeWA
 /9P8NtOU7QMjiu9LE9QbJuAFrI00UhsUZwtALCnUZCv06IxAETKNCx4GgcLzvFqLls/qH/VBh
 +rRu/HTHr2DDBf6DkB2pzwdDdCug/dcM+U/c6GeiJ27BgXQFs5IWmoO1YkU10DhhBhKUkO9Wr
 +Z2sA9Ockb6IcepC/MYcXyyx21JSP2B5JeY/UyWdsGIncx6TqxfAbCI6ncv3cYI+hkweIfUvn
 2AO7ErStSKxxvnLNWDVkHlVbhMzKo/D2YmmBGfTYmCPiXzuX3VngfoWL8NWh7DQlqBA1CuhZZ
 krikpKS1UTBoqEkMFmMMi1/kgE/kCpeBVFV4GOMKglZs3ldRVi0Y2i/JBCKliPWgkM0tZ3c4b
 IDWcpVkKO5eV3ykU+4PRUkZ8TA2JHTBop3OSbzqlSRMfS+6qbYNhBa4NI9nu+aW7t2XeqskJH
 Q0/FyOjU/SUhVD338crEA366qT5Z/nWOJsajv87WtQ/Ik+pPSplL2t2uJJw02xGvlcn5r3XRG
 2Xy/XjzAXOO08+w/0oGJEVb5vwuSTFH9vT3v99TgtXIKNSPscxItrCk6a3Wqp+wft5fH25F4Q
 vch0hj9na4fTx/lPQQ1m36fAFu0cd+HRAO91ICMIgUR/BXuX4Oh1jlE/cNrNuxajIkqv3+oR5
 gmlQWEBW83YH0vGwv
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> How do I get something to match A and B but not C and D (i.e. I do not
> want to match any operations, function calls, etc, only a variable,
> which may be identified through dereference, array index, or struct
> member access.)

I suggest to take software design possibilities a bit more into account
around the application of disjunctions for the semantic patch language.
SmPL disjunctions can be used to search for unwanted source code fragments
before processing the remaining interesting cases.
I would find a direct search approach nicer.
But other special consequences might be usual for such use cases.

Regards,
Markus
