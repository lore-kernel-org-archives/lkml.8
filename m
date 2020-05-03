Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E47AC47247
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 14:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E84C20836
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 14:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQpt/6nH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgECOkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 10:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbgECOkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 10:40:01 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCBFC061A0E;
        Sun,  3 May 2020 07:40:01 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 207so1653665pgc.6;
        Sun, 03 May 2020 07:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vzHd9ZymIKRrpHQ363yCDAXeELoiD3z0sFBKN7UrzMw=;
        b=AQpt/6nHSgT/vFIrn9K9VD/iVoY4CSYAEFCIvU3PbVzADO2eLRuNYvP3qcslY/3wu/
         wjOaylgRpmncoXhUMMfnB+4cqnY8n3fVkisA78mZHFbduwOy+Ccp1sJ+uNbxsAxiExts
         CZ88xPCgDnoYVnbrxoc2AgurjnSIfL1wdIHwJGnT3Vq3TpVmIpsKwhRjMR9K5IOMGpdV
         0Y/AUqB5uLyaTZuYrlBxUApWBk50uSVqCBUq9YL0B+cGj9/3QcEBtSQ+9FiKbPtU/wuj
         qikuzkQ5PVaiP0Ym1QzFKRAyAlCj3jYxTyPyyiS3R81EQU3f5JnZ7WvnJrYcxylqgaO4
         CYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vzHd9ZymIKRrpHQ363yCDAXeELoiD3z0sFBKN7UrzMw=;
        b=s9DpaXNi0jXrYrbjbNtY0wVR4uboREizNqzi2MWAD/i+Q5G3HWxnfzI5tReYEyHPRz
         X0FjAqO6jvgLt7EJtNKyrHIITrqTLhweSuwPT2uCbi1wFNlgcMmwSKb5gdK7+hnNVvk3
         gjlrBQ0Dz4c/UOpgqoxwscUoZwg6SVdcweTXOBfu3nsiuTtI4iOhngjN3oEvnUk8xRdc
         awr1HQ7CAeg/+jOIxU9q7zBzFazkdpcBWh5qZK/UyOgPGacLvBKYf7HVHSA9Lpz69EDS
         0LBJGJuYrYFjoFPGfnScAA6FH6JZfIltx94fO20tOdUWZvynd0g3hx/DdnJznKlUL72C
         vXHQ==
X-Gm-Message-State: AGi0PubH+UssxRCoS7glnn8ylvflOmt8OYscP/ZLkfl+W2gGGpF5NXjU
        K0bHAFceG8MN1YU3H6eZPfZk5DUd
X-Google-Smtp-Source: APiQypItOmlkKQHvj50bJZpfYlwZ2YcQNJn5IrjJdO8lXUr3oS3IMFG5+JBX7VwaIqln1KTFgoUoWw==
X-Received: by 2002:aa7:9689:: with SMTP id f9mr12190591pfk.24.1588516799764;
        Sun, 03 May 2020 07:39:59 -0700 (PDT)
Received: from udknight.localhost ([59.57.158.27])
        by smtp.gmail.com with ESMTPSA id nm22sm4359658pjb.38.2020.05.03.07.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 May 2020 07:39:59 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id 043EbCUm013374;
        Sun, 3 May 2020 22:37:12 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id 043Eb1Mf013372;
        Sun, 3 May 2020 22:37:01 +0800
Date:   Sun, 3 May 2020 22:37:01 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
Subject: Re: [PATCH v5] checkpatch: add support to check 'Fixes:' tag format
Message-ID: <20200503143700.GA12276@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
References: <20200503122938.GC10332@udknight>
 <2d13b5c1-6745-23da-e22d-d56f0644edb2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d13b5c1-6745-23da-e22d-d56f0644edb2@web.de>
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 03, 2020 at 03:51:39PM +0200, Markus Elfring wrote:
> 
> 
> …
> > +					$diagnostics .= "The title is too abbreviated, at least half of orignial commit title is necessary.\n";
> 
> Will the word “original” be more appropriate here?
> (Why did you not integrate my previous patch review comment?)

Sorry, I miss it.

This version patch has indentation issue, I will fix the typo
with the indentation issue in next version (v6).

Thanks.

> 
> 
> …
> > +				      "Please use git commit description style '$prefix <$sha1_length_min+ chars of sha1> (\"<$title>\")' - ie: '${init_char}" . substr($prefix, 1) .
> > +				      " $id (\"$description\")'\n" . $diagnostics . $herecurr);
> 
> Can error diagnostics become multi-line?
The length of "$description" is unknown, it is difficult to
cook the error message into pretty format with any length of
"$description", so let's keep it in current way.

Thanks.
