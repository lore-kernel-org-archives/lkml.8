Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC900C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9A421D56
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bfs.de header.i=@bfs.de header.b="HGKCnRqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgCJR5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:57:54 -0400
Received: from mx01-muc.bfs.de ([193.174.230.67]:38018 "EHLO mx01-muc.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgCJR5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:57:54 -0400
Received: from SRVEX01-SZ.bfs.intern (exchange-sz.bfs.de [10.129.90.31])
        by mx01-muc.bfs.de (Postfix) with ESMTPS id C4BD3203A9;
        Tue, 10 Mar 2020 18:57:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1583863072; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l+KTk0oh5PS89rpVNJOhxUeEwOxL9f315/ZTVj0gI5U=;
        b=HGKCnRqvi3RsffKtAtxs2JnxVYQ7lmcyLnj75nvtxvmUCTAUOvYbL4NlMPMDsCd7HRB2gc
        dcW4tfxI2G0ygVzq90EPbo/8JnRmxFyOlf1MH4iuJZQa4cfVaxu8himrwB0eiNob3xb3m/
        9MZvt9I6QFiZUbHHkRwW1Xld20b8jJtmX2xGC+UCfXDFAU3/Z2md9JwDLU+T/iUkzRbASD
        Vq/405dtOFCb6/nYJb9o00OqZzJGkKYufXkUhjFvrEBWhNo7xRwKyYMEmQoABkDr/uzN0A
        fk0S7XJB0XnmsRWNPtxcRIR8W+Yyc6E1eTQcKhnud78CWu7l1kANMKFX+23wDA==
Received: from SRVEX01-SZ.bfs.intern (10.129.90.31) by SRVEX01-SZ.bfs.intern
 (10.129.90.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.1913.5; Tue, 10 Mar
 2020 18:57:18 +0100
Received: from SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a]) by
 SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a%6]) with mapi id
 15.01.1913.005; Tue, 10 Mar 2020 18:57:18 +0100
From:   Walter Harms <wharms@bfs.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: AW: [PATCH] bfs: prevent underflow in bfs_find_entry()
Thread-Topic: [PATCH] bfs: prevent underflow in bfs_find_entry()
Thread-Index: AQHV9EblEVE9iA1yzEeR1GKKiiXYdag/8IotgAGMlQCAAKOu/A==
Date:   Tue, 10 Mar 2020 17:57:18 +0000
Message-ID: <fabccce3c25444bbb5aa51f8c08e9865@bfs.de>
References: <20200307060808.6nfyqnp2woq7d3cv@kili.mountain>
 <ba294b1d861142ca8f7b204356009dd0@bfs.de>,<20200310090644.GA11583@kadam>
In-Reply-To: <20200310090644.GA11583@kadam>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.137.16.40]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Authentication-Results: mx01-muc.bfs.de
X-Spamd-Result: default: False [0.03 / 7.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         HAS_XOIP(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         BAYES_SPAM(0.03)[51.61%];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM(-0.00)[-0.991,0];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[gmail.com];
         MID_RHS_MATCH_FROM(0.00)[];
         RCVD_COUNT_TWO(0.00)[2]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


________________________________________
Von: Dan Carpenter <dan.carpenter@oracle.com>
Gesendet: Dienstag, 10. M=E4rz 2020 10:06
An: Walter Harms
Cc: Tigran A. Aivazian; linux-kernel@vger.kernel.org; kernel-janitors@vger.=
kernel.org
Betreff: Re: [PATCH] bfs: prevent underflow in bfs_find_entry()

On Mon, Mar 09, 2020 at 08:40:28AM +0000, Walter Harms wrote:
> hi Dan,
> the namelen usage is fishy. It goes into bfs_namecmp()
> where it is checked for namelen < BFS_NAMELEN, leaving
> only the case =3D=3D.

The rule in bfs_namecmp() is that the name has to be NUL terminated if
there is enough space.

that raises the question why is there a len paramter in the first place.
Surely the writer can make sure that there is always a NUL terminated
string, then it would be possible the use a simple strcmp() and the
range check is useless and can be removed.

seems a question for the maintainer.

re,
 wh
