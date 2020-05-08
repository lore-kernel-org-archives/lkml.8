Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7B9C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8073A21841
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="hgSKOuwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgEHPnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 11:43:25 -0400
Received: from mout.web.de ([217.72.192.78]:49095 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbgEHPnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588952549;
        bh=Q0M54iaQfTx/siQf5AYxkuXAwOG3MGeXnJDWoLBUUG8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hgSKOuwzJr1pJ39T2HikMasrV4sBk5XYzff9S46kGixa40A80T6IgfEJvC81KM0WT
         eXOQfm7qlilLrhmRNPuQHwU64/PbnMnKasFacYI2aqEBI2sEbYPVbwwHQmkD2RU9mp
         3bRiXANn9S734zDnrSldvbW+XPZNajRimsAUqnJE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.146.138]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJWsc-1jqnr32NOi-00K2aG; Fri, 08
 May 2020 17:42:29 +0200
Subject: Re: [PATCH v4] tools/bootconfig: Completion of error handling
To:     Yunfeng Ye <yeyunfeng@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <bdda096b-9f8a-dacb-9f89-9077d1288ad7@huawei.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <839d6c0f-4c77-d8f4-3aff-c5762190c57e@web.de>
Date:   Fri, 8 May 2020 17:42:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <bdda096b-9f8a-dacb-9f89-9077d1288ad7@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fq+oQAiyBcB7uyxqcBPUfqHyg4Zxep+WhGzXEKKzYW+RTo1+7hb
 V1CwleNqcaThd6kTcV49G9y/UaeQjq7SCN4HfXtJICSki0mTc2Rgy4bfVwKqy9m4G9wREg4
 z2i7oHRlLW4cCOJBNSN1H88TY2zGbK+PSOVDSUBJosz7Vlye6qoE6//eSBVTDWEiQvhEg7s
 Azr6TUP5X2m6cu4X0rt9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TdqqzrJY158=:23osdqmCnHvFRdeVumsNtA
 D5n3vujCdd0R6YbPIqKIZJWzmCecTknjsIB18rexOzanBTFi6ek5SMscRE7fx68GHgAe5NH02
 hxZ5tfKZJHRMlmvaEfVF29irGRTjmBBdd85t3N2VVKPhGIwjcu48qmyUh5VYVrI5uy+WDbTn9
 6yZfCBi4Kj5p+Wvq37E3G5QTtZQKISTDDRCxvhIvFKwlILPEP4o8/roGiHYXbhn3Vqt8wXiLO
 hJwy2qQUtQ/PLZO9u4TRxRbK/nv0bwwzsPG4p89l8HvH+4GSVXShTrOjHugJkBLO00oklbiZ0
 tYwKJL2qhMgasYHdw3Og94drySLsTafQPeVFd0VHEVabbo5AFjgeGXS5+q/CKpbYvV3LpDutw
 8jUmVe8iwC2GdZ6AqDwAONPOwqYVZfbNjPfxZAZbkKR7QTAQt433Ih6YBsA01vBxou7sJtS4k
 s1MyWcrc5U6dDed3ILpy5Hi+Qc2K7WeAeb7kWLB/0w1HfS/3RzSk9mChBnuQE5aZSC71tORNk
 VvZreFmvUMYpDrE1jpaO09/8Nd2M76zhr+HwukmUSnRQM4AOwwEMZmdbqNMkXq7l1ohfn28su
 drp4xQU61W+D9QUSsHs/EdHTzQXbldFHF14QnElJ0ZFOCNESCcj/M/kAPmbVmfAVDWPOt6j/3
 tRvNEojMiiy3a+/3nuWdWRYOvxL4PrPf+HgeS6XCre1dHyUH/QM+XOt/8HLatOGjDPkgMhm0w
 ijiebyaRXqSgxCuvBmQ9ra7GMCpNT+kTVCt525WhpFrPBfT28LUSXI7v7IPQZYbyKorORTRkE
 6j8gqKcJqtsUo72njMPjnX5xqwXKb6bgeGykHVBDLlrS1V/crMs3w0Dxc2GTrudk7/vOm7gyV
 yqnGD9lylcd7AOPInOet69Chvi9opfycaZWOYXDeYB9qPIk41iVEpy3hZIukXtqwFNIZCsF4O
 cTBlxMDem8XCkq2D8p826LA9wba9uzb8kf35dqSkzk3V4GB3vRCKAPqgdANTtLxcycaV9LF7z
 5ePzNCkm7/A793quw9mSUxKEfXaTnc3nnN75D1W0tZNMexLvNFIUDUWD5w1jjXlc9gPlU34ZK
 H5xwyLLFd3qX8oRA22FwI1L4e0j61ZWG3th/3F4ajbo6PtDzDSnOLKGDYfCR1PvchZaKBifFO
 X7xy/wb/3Yxawgv7tKSycb+gr2vqBnb66RUTW7cUDa36MlKb+9CnnB0ZN0LB1oVQkeBSmajqg
 JUPHSbgcQUS5brv7d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +++ b/tools/bootconfig/main.c
> @@ -314,31 +314,35 @@ int apply_xbc(const char *path, const char *xbc_pa=
th)
=E2=80=A6
> +close_fd:
>  	close(fd);

Do analysis tools point any software development concerns out
at this source code place?
https://wiki.sei.cmu.edu/confluence/display/c/ERR33-C.+Detect+and+handle+s=
tandard+library+errors#ERR33-C.Detectandhandlestandardlibraryerrors-Automa=
tedDetection

Regards,
Markus
