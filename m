Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B70C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696FC20789
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="VXkUZHjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgCTLYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 07:24:51 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:13690 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgCTLYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 07:24:51 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 8268C40D49;
        Fri, 20 Mar 2020 12:24:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1584703488; x=1586517889; bh=L4wPJtn50I51+Mq1xXTEU9qAXC8zThyChF1
        UTylT4Ek=; b=VXkUZHjlkIg9lQ+dbJJk7fhtnrnjYZ1/w86vPvJxqb6wodOWjUX
        kMQHTrxi7FFv/hN4dmQTa4LeHQGqwIHfe4PhaX8MPEyFVnE046LFWsj7NX1PkRuX
        N4LWEGv9cF2ySkygQ6woBlK/SJZJ+rbDMs+Hhb6fVM3NJlgYRmbIACDpZojnB3w4
        7MYLFBwsTF8lQ6YT5fTGf3Wn06+SeHSLzaEGvt+laCgFfHXM8ceUBFVoa4uFRvXx
        ErhTbA10xbOln6juYvX1ma4KpI8lqy4AvSgNOfz5VuG217iZoaGMPCNUh0qkVbw9
        sA2Dq9TykTJKZwZwtaVLD/Jz2nNW6lDcEt197LaJnVxpLBnkwXHgJ20s+pukLM9l
        si++ZXQ+c0X+Thxd1p1Irlw8ZbY83td2dzVltngtGbBy+82z/jSYVmgjONS2Nrhm
        K3P6I0NdIY59Ot+pxWd+1x+k568aZfdO4Fplw3kZHAyLR5iAMM0HwYZLZJ5C9rFb
        CWk1eSCemF+OeZkPxhErCQi6PH+d+/TVToPnPtxGaFeqIG6STdLF3IxwVdVCjIKl
        GdpFg+XnlTF2K98eNVEPWBiCSrwZntCfCnr7mudL5hY9zd7ywD3J+uY8eGii6ety
        j5vMvuTwtejdEjovEATwmqDFp7DkRWBy4lp02VctVCU+OFHzKuiRed3E=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vEpvX-rmhzOR; Fri, 20 Mar 2020 12:24:48 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 0A31140D30;
        Fri, 20 Mar 2020 12:24:46 +0100 (CET)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 9F7256948;
        Fri, 20 Mar 2020 12:24:46 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] docs: conf.py: avoid thousands of duplicate label warning on Sphinx
Date:   Fri, 20 Mar 2020 12:24:45 +0100
Message-ID: <3508337.2CZTLhteCP@harkonnen>
In-Reply-To: <16f1c270a9077032de379b1cb30dfbb3e3670aee.1584702515.git.mchehab+huawei@kernel.org>
References: <20200320112122.48244ec4@coco.lan> <16f1c270a9077032de379b1cb30dfbb3e3670aee.1584702515.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 20, 2020 12:12:35 PM CET Mauro Carvalho Chehab wrote:
> The autosectionlabel extension is nice, as it allows to refer to
> a section by its name without requiring any extra tag to create
> a reference name.
> 
> However, on its default, it has two serious problems:
> 
> 1) the namespace is global. So, two files with different
>    "introduction" section would create a label with the
>    same name. This is easily solvable by forcing the extension
>    to prepend the file name with:
> 
> 	autosectionlabel_prefix_document = True
> 
> 2) It doesn't work hierarchically. So, if there are two level 1
>    sessions (let's say, one labeled "open" and another one "ioctl")
>    and both have a level 2 "synopsis" label, both section 2 will
>    have the same identical name.
> 
>    Currently, there's no way to tell Sphinx to create an
>    hierarchical reference like:
> 
> 		open / synopsis
> 		ioctl / synopsis
> 
>   This causes around 800 warnings. So, the fix should be to
>   not let autosectionlabel to produce references for anything
>   that it is not at level one, with:
> 
> 	autosectionlabel_maxdepth = 1

So, for level 1 headers is fine to use autosectionlabel, but if we want to 
refer to level 2,3... we have to create labels manually.

Fine with me




