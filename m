Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA92AC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B5720409
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVIzZxj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgCJTKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:10:55 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:45218 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgCJTKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:10:55 -0400
Received: by mail-il1-f196.google.com with SMTP id p1so9050430ils.12;
        Tue, 10 Mar 2020 12:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=jjnyhl2FYqCdEa8C1IU6yaoLQD+IEMohhTYkXDXFwXg=;
        b=iVIzZxj52oys0hJS3rR/En8hMcB36oUDmU63gslfN7T0CTSFQ7LBnATPWjw/nOZGAK
         9TK3a7XXJWAt3I0yBdHuYjF54vSYKQtgERNSOnCY5DwbKOn+Rr5yhv0Ul64DwmwxSbSR
         +GNnenSEEDZXs1Cyr2Xf+SO9gBUHIKqRpNnZHQZs5pNAHl6U9yYn2TBA09FFVo3W+Nc/
         E2wXK6uM1sGIB1Gmp2wbb10RMX4E0QK6FXOkre2zhFrAhrZrHx1TUlnYEgDjwo00s7sK
         AUa+QCSVaBxxKi55raD9RaTVe7jA867nGaDgmJj9Zdt9X7pe74jUL+7XWd5FVn2Uwf1L
         tf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=jjnyhl2FYqCdEa8C1IU6yaoLQD+IEMohhTYkXDXFwXg=;
        b=G2uiqNQAoLaq2gaL394WfMEIoYgE47+JDjJHvc5OCn9FqABcrggJUqQuhwfsx5zIF4
         Hu1cjYA8NJDhuhnuLUNw+8i2sgutJ1pTfjUjc4UkrLZuu0CPoF89abbBfz6lzXnoT8TO
         gqSZY+WHjwlQlU6b5IgzUwUjDy0lxzYjjGjcyQPXhUSNOcHTjvsRnQ+x2vZm8voSyyYC
         GM7lc789F5AlmwE6lc4zXbPbkUZMjLGT88Kg/BbnAKpJj/DsHWTB3RmsAzUDJ47zJk3K
         ZxpxAtPZSRAkOFJDYTYrVp01TXhNRR3JYXbJTZQ90uJnc0VzWwILOVguzUHCtA7D7b42
         6ogg==
X-Gm-Message-State: ANhLgQ1/C0xii8DRftHiv1zmBmSkpPESHoEQ0wP1o0Ebn8pgyPFC8NHz
        EqqsPmAe4xKJkyHMCmAX5SaVPg7AE9wwFECIigP80HhA
X-Google-Smtp-Source: ADFU+vvXcT/o8b1SSUtJFkEDsr3+Ew6tI4k1rSEuqXV6mIs7zKvrePUZLJRwO5bJLHj3hQ2X3q6S7DVAhpp33yviBuM=
X-Received: by 2002:a92:d702:: with SMTP id m2mr20771311iln.149.1583867454421;
 Tue, 10 Mar 2020 12:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200310100759.221c6add@canb.auug.org.au>
In-Reply-To: <20200310100759.221c6add@canb.auug.org.au>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Tue, 10 Mar 2020 14:10:43 -0500
Message-ID: <CABhMZUUSJTCVuS+2svEJcLGSuKxwCxznxCHa9tUUL7cr_teg_g@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the pci tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 6:08 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the pci tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
>
> ERROR: "pci_speed_string" [drivers/pci/controller/pcie-brcmstb.ko] undefined!
> ERROR: "pcie_link_speed" [drivers/pci/controller/pcie-brcmstb.ko] undefined!

Fixed, thanks!
