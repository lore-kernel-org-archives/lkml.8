Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A5CC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0311C20752
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q/07svVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgCROq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:46:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49136 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgCROq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 10:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=22sVcNbDCzARdRFC3MRVT7FnYchnm76kK5yHdzlXjIo=; b=q/07svVZajs+gu/v8igGPgZbpb
        cYjBvKo/McnsG3YrnLst9dR2GjXqaL0a2ed/uPoTg/5TQn1WJxmgpbCzTTTDzqvJSHC66CkhyuV1X
        b/ctGrv+vfF6KzNjM+rG2j9oeXvuTI+hYB6CeQ6jV/bJRHppOIhH1rMPAZFXxNH4WaNQ93eaNDtU4
        PwRxwv9zUJEluh1weB8o8khCCmCZ1gIUM9prZbpDo81X2M13utKut4SHAuzza2cQQap6eGCqEKNgU
        IpfQeocX61rd+wD0zxCQZS8rIbTFUITytw9uuA8k3BmHt4idJqeqXpzQ9kRbMvyBkPH1Tygt1VpPE
        OiS+5sHw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEZxk-0002I7-NA; Wed, 18 Mar 2020 14:46:28 +0000
Date:   Wed, 18 Mar 2020 07:46:28 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH] fs/namespace: handle mount(MS_BIND|MS_REMOUNT) without
 locking sb->s_umount
Message-ID: <20200318144628.GI22433@bombadil.infradead.org>
References: <158454107541.4470.14819321770893756073.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158454107541.4470.14819321770893756073.stgit@buzz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 05:17:55PM +0300, Konstantin Khlebnikov wrote:
> @@ -459,11 +459,11 @@ void mnt_drop_write_file(struct file *file)
>  }
>  EXPORT_SYMBOL(mnt_drop_write_file);
>  
> +/* mount_lock must be held */
>  static int mnt_make_readonly(struct mount *mnt)
>  {
>  	int ret = 0;
>  
> -	lock_mount_hash();

I'd rather see
+	lockdep_assert_held_write(&mount_lock);
than a comment.  Maybe wrapped up into a macro like assert_hash_locked().

