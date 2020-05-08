Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B344C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1526208D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="bLsy6DKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgEHIYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:24:30 -0400
Received: from mout.web.de ([212.227.15.3]:57065 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgEHIY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588926224;
        bh=0ci8plH2JdbD4aoJkM2HMdrMD5RZ7jwNRS140WJowwI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=bLsy6DKgWkL/qIUq4s9y8V7UpW1LbuW5a0H5hqEfCxBkA1NArNDGFKauasCd0zWTV
         51w6Q8SMu+h9ZcR5eWPVk6oAJfj7PRnXDFujzMiW7smZ7LE147XdIP3dOiXycFaNgr
         VDxhdgJCNHSdKnb3VBBCQhAJ7hC4u83gINtcNf1U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.146.138]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MSIwN-1jiM323o31-00TSUH; Fri, 08
 May 2020 10:23:44 +0200
Subject: Re: [PATCH v2] tools/bootconfig: Completion of error handling
To:     Yunfeng Ye <yeyunfeng@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <189d719f-a8b8-6e10-ae2f-8120c3d2b7a9@huawei.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Message-ID: <0b2612c1-28ca-2bb0-14f1-4befea09cede@web.de>
Date:   Fri, 8 May 2020 10:23:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <189d719f-a8b8-6e10-ae2f-8120c3d2b7a9@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cDSxwuiOZx8PqG6JOV4eXH9+l4ObsqBdlyO/ztaOCCkWPe5gmUM
 zJb4RoXTBQU7msd7G2MoCm1Ad2qP5ql3dFLD50hGX/1P/cAJFoN+ZoTFyAGa0VzJ+IssvX2
 LsgVP4l5dMXhNLspxcN+YDvDEABr8olN/SZsGQsURl5TcLWTMrgLWZkz+TGB6yq4zHSIg+/
 M4KOFhSaFgndVzDW/hezQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YaTaw6Q+cJ8=:+5qzNIW3ENfdtYwWRl9eI4
 TfMEpiBlSTeNSqLUrkHNEbdab4J94J2AMiKluENtNiU3XZvF9FZ+2e1I7iVf1DBdIcAnTpBxu
 Tbha+bSoiRJxiZeqmLb/We/iqXw+hA8zSAKUJblC59Q7Z5cnV26pNFGCNMS4ILM0QJ+dAz/2S
 WlmnJcHJ7ZLfv5y5UjvBPrgVvL3C+rqybvPTXp4t20cWAiff2do9SRu6bFzMDIwWNjoTS5kXY
 Gf5S11gW3bY/dWo5IL5AEmXeuHagMTD9r9HTx2hjA8udU9t/2jPAh60OopmQ0JYqswHZvwv3q
 EEZdGq51LaiOx3kyAVsj/u3uA+h0LGa88okWTx7TUg2zEBzoafeH8vuH1V5ToxVlCpRg1JDKc
 5tYALz8uDv6SwoPWrffCe5SruhzNJ1e5256CgYpBeHcMTHN7qCP6tkskKQybGBlbZor0pzj4P
 RZkiFaMUziXdyB2/4PlwotDRudKBDq7YaQqXGAAAKMcz3pQ1T65E7n/DIPLXpLqIPH8oRvo1Z
 FyqTswVMwe2HsveaLRqeRK4VQnDacFlvl5dk/gDdDBVV0NNlzwUeDDelnJxGlICCOoXkR9KZd
 vKl2AhGlzxy9vGqVN+RfR2o2FW9RRl+k39zx9o1SHTIFfo8bLUODZMi254cVAsrCbzHFTA2yI
 JrYZ20f/xNwUGBieOoAp14MluAdmxA4gwkgQzocu2htU9C4azNx1/JFOYb2n4VTB6l80s/+uG
 MhT6JnlkIhAx98x4sWRJFqfiQpaRgQfcHSbyZgx9R8sJ3kazlEpe6kee4LDja5KRVBPYvwKvF
 8UGO0E4m4Oys7baDGlH86W+HVdQV18laiR1FyQdzeUsurN/GJTqN2X9J2rg8ybnFhziC39qm3
 2rF1Hn8hEmEMhOqBJPZRsWM8/5TCqGLpeuiCf1T/E6ohpy2JHEk180JLjxN2t+E5LcAMRXVJi
 ee1/xxOxpadsL0PRU5MDLrhj2vBG1veuZ2aJF7N38N224uPa+Jyvt2gPrNZBQ7yWpgiLGVpHj
 EdejwmBg2/J0LhJasTtIcsh0TJRQ3W81chkl42JgQFne4PHl9zRlb2fiWZ9VEY+CBH/FtwQ/y
 lKFdd4GhDaIEquHqfTmVdyTHlTJbOlSLl8V1PFHp/mPBEsswmu13ZlBcy20Fozzh+vygma6Wy
 mwre+wn9msx+SAjHNMjHPqj5y30bDsDQdQCcMwF7DXiuTFtUEWWKb6EHgQH7jDXrOGk0ccAzA
 +Z86ZmFiVkbPWt0ja
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +++ b/tools/bootconfig/main.c
> @@ -314,31 +314,33 @@ int apply_xbc(const char *path, const char *xbc_pa=
th)
=E2=80=A6
> +close_fd:
>  	close(fd);
> +free_data:
>  	free(data);
=E2=80=A6

Do you find unchecked return values from calls of functions like close()
and printf() suspicious?
https://cwe.mitre.org/data/definitions/252.html

Regards,
Markus
